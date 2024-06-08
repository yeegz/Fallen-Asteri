extends CharacterBody2D

#variable declaration
const JUMP = -550
const SPEED = 320
var enemy = null
var GRAVITY_VALUE = 1100
var player_attack_range = false
var player_attack_range_left = false
var player_attack_cooldown = false
var player_attack_cooldown_left = false
var stamina_requirement_attack = 30
var pre_attack_cooldown = false
var pre_attack_cooldown_left = false
var attack_animation = false
var facing_right = null
var dash_distance = 500
var dash_cooldown = false
var dash_stamina_requirement = 50
var is_dashing = false
var is_attacking_right = false
var is_attacking_left = false
var direction = 0
var knockback_right = false
var knockback_left = false
var knockback_distance = 1000
@onready var animation = $AnimatedSprite2D
@onready var  audio_stream_player_2D = $AudioStreamPlayer2D as AudioStreamPlayer2D
@onready var  combat_audio_stream_player_2D = $AudioStreamPlayer2D2 as AudioStreamPlayer2D

#main function
func _process(delta):
	var control = controls()
	gravity(delta)
	animations(control)
	if facing_right == true:
		player_attack_right()
	elif facing_right == false:
		player_attack_left()
	death()
	healthbar()
	staminabar()
	audio_functions()
	if global.sideboss_dead == true:
		dash(facing_right)
	if Input.is_action_just_pressed("save"):
		global.save(global.data)
	if Input.is_action_just_pressed("load"):
		global.load()
	xp_calc()
	xpbar()
	print(global.data)


#Easiest way for enemy hitbox to identify player is through methods.
func hero():
	pass

#player controls and sprite flipping according to direction
func controls():
	#Added buttons A and D to the left and right axis respectively
	if Input.is_action_pressed("ui_left") and is_attacking_right == false and is_attacking_left == false:
		direction = -1
	elif Input.is_action_pressed("ui_right") and is_attacking_right == false and is_attacking_left == false:
		direction = 1
	else:
		direction = 0
	
	
	#Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept") and attack_animation == false:
		velocity.y = JUMP
	
	#Movement. 
	if direction and attack_animation == false:
		velocity.x = SPEED * direction
		if direction == 1:
			$AnimatedSprite2D.flip_h = false
			facing_right = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = true
			facing_right = false
	elif direction == 0 or velocity.x == 0:
		
		#requires move_towards to enable stopping movement
		velocity.x  = move_toward(1, 0, 1)
	
	#move_and_slide required for basic physics functions to work
	move_and_slide()
	return direction

#basic gravity
func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta

#animations
func animations(control):
	#Animation
	if control and velocity.y == 0 and attack_animation == false:
		animation.play("run")
	if Input.is_action_just_pressed("ui_attack") and global.PLAYER_STAMINA >= stamina_requirement_attack and is_attacking_left == false and is_attacking_right == false:
		attack_animation = true
		$attack_anim_timer.start()
		if attack_animation == true:
			animation.play("attack")
			combat_audio_stream_player_2D.play()
	elif velocity.y != 0 and attack_animation == false:
		animation.play("jump")
	elif control == 0 or velocity.x == 0:
		if attack_animation == false:
			animation.play("idle")

#when any interactible object with the method "enemy" enters
func _on_player_attack_range_body_entered(body):
	if body.has_method("enemy"):
		enemy = body
		player_attack_range = true

#when any interactible object with the method "enemy" exits
func _on_player_attack_range_body_exited(body):
	if body.has_method("enemy"):
		enemy = null
		player_attack_range = false

#player attack cooldown, player stamina calculation and cooldown
func player_attack_right():
	if Input.is_action_just_pressed("ui_attack") and global.PLAYER_STAMINA >= stamina_requirement_attack and is_attacking_right == false:
		is_attacking_right = true
		player_attack_cooldown = true
		$player_cooldown.start()
		if player_attack_cooldown == true and global.PLAYER_STAMINA >= stamina_requirement_attack:
			global.PLAYER_STAMINA -= stamina_requirement_attack
		if global.PLAYER_STAMINA < global.PLAYER_MAX_STAMINA:
			$player_stamina.start()
		if player_attack_cooldown == true and player_attack_range == true:
			pre_attack_cooldown = true
			$pre_attack.start()

#what player being able to attack on cooldown timeout
func _on_player_cooldown_timeout():
	player_attack_cooldown = true
	is_attacking_right = false

#player regenerating stamina upon stamina depletion
func _on_player_stamina_timeout():
	if global.PLAYER_STAMINA < global.PLAYER_MAX_STAMINA:
		global.PLAYER_STAMINA += global.STAMINA_RECOVERY

#handles character death temporarily. An end screen is more fitting
func death():
	if global.PLAYER_HP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://deathscreen.tscn")


#function to link healthbar GUI to PLAYER_HP
func healthbar():
	var healthbar_parameters = $health
	healthbar_parameters.max_value = global.PLAYER_MAX_HP
	healthbar_parameters.value = global.PLAYER_HP
	if global.PLAYER_HP > global.PLAYER_MAX_HP:
		global.PLAYER_HP = global.PLAYER_MAX_HP

#function to link staminabar GUI to PLAYER_STAMINA
func staminabar():
	var staminabar_parameters = $stamina
	staminabar_parameters.max_value = global.PLAYER_MAX_STAMINA
	staminabar_parameters.value = global.PLAYER_STAMINA
	if global.PLAYER_STAMINA == global.PLAYER_MAX_STAMINA:
		staminabar_parameters.visible = false
	else:
		staminabar_parameters.visible = true

#able to sync attack to animation, player attack
func _on_pre_attack_timeout():
	if pre_attack_cooldown == true and player_attack_range == true:
		enemy.animation.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		enemy.animation.modulate = Color.WHITE
		enemy.ENEMY_HP -= global.PLAYER_ATTACK_DAMAGE
		
	
	pre_attack_cooldown = false

#Handle timing for attack animation
func _on_attack_anim_timer_timeout():
	attack_animation = false

#handle audio
func audio_functions():
	if Input.is_action_just_pressed("ui_accept") and attack_animation == false:
		audio_stream_player_2D.play()

#handle attacks to the left
func _on_player_attack_range_left_body_entered(body):
	if body.has_method("enemy"):
		enemy = body
		player_attack_range_left = true

#handle attacks to the left
func _on_player_attack_range_left_body_exited(body):
	if body.has_method("enemy"):
		enemy = null
		player_attack_range_left = false

#handle attacks to the left
func player_attack_left():
	if Input.is_action_just_pressed("ui_attack") and global.PLAYER_STAMINA >= stamina_requirement_attack and is_attacking_left == false:
		is_attacking_left = true
		player_attack_cooldown_left = true
		$player_cooldown_left.start()
		if player_attack_cooldown_left == true and global.PLAYER_STAMINA >= stamina_requirement_attack:
			global.PLAYER_STAMINA -= stamina_requirement_attack
		if global.PLAYER_STAMINA < global.PLAYER_MAX_STAMINA:
			$player_stamina.start()
		if player_attack_cooldown_left == true and player_attack_range_left == true:
			pre_attack_cooldown_left = true
			$pre_attack_left.start()

#handle attacks to the left
func _on_player_cooldown_left_timeout():
	player_attack_cooldown_left = true
	is_attacking_left = false

#handle attacks to the left
func _on_pre_attack_left_timeout():
	if pre_attack_cooldown_left == true and player_attack_range_left == true:
		enemy.animation.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		enemy.animation.modulate = Color.WHITE
		enemy.ENEMY_HP -= global.PLAYER_ATTACK_DAMAGE
		
	
	pre_attack_cooldown_left = false

func dash(direction):
	if Input.is_action_just_pressed("ui_dash") and global.PLAYER_STAMINA >= dash_stamina_requirement and is_dashing == false:
		dash_cooldown = true
		is_dashing = true
		$dash_timer.start()
	if dash_cooldown == true and direction == true:
		velocity.x += dash_distance
		move_and_slide()
		animation.play("dash")
	elif dash_cooldown == true and direction == false:
		velocity.x = -dash_distance
		move_and_slide()
		animation.play("dash")
	elif dash_cooldown ==  false:
		velocity.x = SPEED

func _on_dash_timer_timeout():
	dash_cooldown = false
	is_dashing = false
	global.PLAYER_STAMINA -= dash_stamina_requirement


func xp_calc():
	if global.PLAYER_XP >= global.PLAYER_MAX_XP:
		global.PLAYER_LEVEL += 1
		global.PLAYER_MAX_XP += 5
		global.PLAYER_ATTACK_DAMAGE += 10
		global.PLAYER_MAX_STAMINA += 10
		global.STAMINA_RECOVERY += 5
		global.PLAYER_XP = 0

func xpbar():
	var xpbar_parameters = $XPbar
	xpbar_parameters.max_value = global.PLAYER_MAX_XP
	xpbar_parameters.value = global.PLAYER_XP

func knockback():
	if facing_right == true:
		knockback_left = true
		$knockback_left_timer.start()
		if knockback_left == true:
			velocity.x -= knockback_distance
			move_and_slide()
	
	elif facing_right == false:
		knockback_right = true
		$knockback_right_timer.start()
		if knockback_right == true:
			velocity.x += knockback_distance
			move_and_slide()


func _on_knockback_right_timer_timeout():
	knockback_right = false


func _on_knockback_left_timer_timeout():
	knockback_left = false


