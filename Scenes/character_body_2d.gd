extends CharacterBody2D



#variable declaration
var SPEED = 320
const JUMP = -550
var enemy = null
var GRAVITY_VALUE = 1100
var PLAYER_HP = 200
var PLAYER_STAMINA = 100
var player_attack_range = false
var player_attack_cooldown = false
var stamina_requirement = 30
var pre_attack_cooldown = false
var attack_animation = false
@onready var animation = $AnimatedSprite2D
@onready var  audio_stream_player_2D = $AudioStreamPlayer2D as AudioStreamPlayer2D

#main function
func _process(delta):
	var control = controls(delta)
	gravity(delta)
	animations(control)
	player_attack()
	death()
	healthbar()
	staminabar()

#Easiest way for enemy hitbox to idintify player is through methods.
func hero():
	pass

#player controls and sprite flipping according to direction
func controls(delta):
	#Added buttons A and D to the left and right axis respectively
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP
		audio_stream_player_2D.play()
	
	#Movement. 
	if direction:
		velocity.x = SPEED * direction
		if direction == 1:
			$AnimatedSprite2D.flip_h = false
		elif direction == -1:
			$AnimatedSprite2D.flip_h = true
	elif direction == 0 or velocity.x == 0:
		
		#requires move_towards to enable stopping movement
		velocity.x  = move_toward(1, 0, delta)
	
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
	if control and velocity.y == 0:
		animation.play("run")
	elif Input.is_action_just_pressed("ui_attack") and PLAYER_STAMINA >= stamina_requirement:
		attack_animation = true
		$attack_anim_timer.start()
		if attack_animation == true:
			animation.play("attack")
			audio_stream_player_2D.play()
	elif velocity.y != 0:
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
func player_attack():
	if Input.is_action_just_pressed("ui_attack") and PLAYER_STAMINA >= stamina_requirement:
		player_attack_cooldown = true
		$player_cooldown.start()
		if player_attack_cooldown == true and PLAYER_STAMINA >= stamina_requirement:
			PLAYER_STAMINA -= stamina_requirement
		if PLAYER_STAMINA < 100:
			$player_stamina.start()
		if player_attack_cooldown == true and player_attack_range == true:
			pre_attack_cooldown = true
			$pre_attack.start()

#what player being able to attack on cooldown timeout
func _on_player_cooldown_timeout():
	player_attack_cooldown = true
	

#player regenerating stamina upon stamina depletion
func _on_player_stamina_timeout():
	if PLAYER_STAMINA < 100:
		PLAYER_STAMINA += 10

#handles character death temporarily. An end screen is more fitting
func death():
	if PLAYER_HP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://deathscreen.tscn")
		
		

#function to link healthbar GUI to PLAYER_HP
func healthbar():
	var healthbar_parameters = $health
	healthbar_parameters.value = PLAYER_HP

#function to link staminabar GUI to PLAYER_STAMINA
func staminabar():
	var staminabar_parameters = $stamina
	staminabar_parameters.value = PLAYER_STAMINA

#able to sync attack to animation, player attack
func _on_pre_attack_timeout():
	if pre_attack_cooldown == true and player_attack_range == true:
		enemy.ENEMY_HP -= 20
	
	pre_attack_cooldown = false

#Handle timing for attack animation
func _on_attack_anim_timer_timeout():
	attack_animation = false
