extends CharacterBody2D

#variable declaration
const GRAVITY_VALUE = 1100
var SPEED = 70
var JUMP = -500
var player = null
var player_chase = false
var attack_range = false
var attack_range_left = false
var attack_cooldown = true
var attack_cooldown_left = true
var player_alive = true
var alive_status = true
@onready var animation = $AnimatedSprite2D
@onready var audio_stream_player_2D = $AudioStreamPlayer2D as AudioStreamPlayer2D

#main function
func _physics_process(delta):
	gravity(delta)
	animations(player_chase)
	pathing(player_chase, delta, SPEED)
	death()
	enemy_healthbar()

#throwaway function, might or might not find use later
func enemy():
	pass

#when player enters DetectionArea
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

#when player exits detection area
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

#when player enters hitbox area
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("hero"):
		attack_range = true
		if attack_range == true:
			attack_cooldown = false
		if attack_cooldown == false and attack_range == true:
			$pre_attack_enemy_cooldown.start()

#when player exits hitbox area
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("hero"):
		attack_range = false

#enemy attack, attack cooldown
func enemy_attack():
	if attack_cooldown == false and attack_range == true:
		global.PLAYER_HP -= 20
		audio_stream_player_2D.play()
		attack_cooldown = true
		$cooldown.start()

func enemy_attack_left():
	if attack_cooldown == false and attack_range_left == true:
		global.PLAYER_HP -= 20
		audio_stream_player_2D.play()
		attack_cooldown = true
		$cooldown_left.start()

func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	move_and_slide()

#enemy animations
func animations(player_chase):
	#Animation
	if player_chase == false:
		animation.play("enemy_idle")
	elif attack_range == true or attack_range_left:
		animation.play("enemy_attack")
	elif attack_cooldown == true:
		animation.play("enemy_walk")

#pathfinding, knockback
func pathing(playerchase, delta, speed):
	if playerchase == true:
		
		#move towards player if in detection area
		position += (player.position - position)/ speed
		#to prevent enemy from sliding
		move_toward(1, 0, delta)
		
		#Flip sprite according to direction
		if player.position < position:
			$AnimatedSprite2D.flip_h = true
		elif player.position > position:
			$AnimatedSprite2D.flip_h = false
		
		#Knockback
		#if player.position < position and attack_range == true and attack_cooldown == true:
			#player.position.x += -knockback * delta
		#elif player.position > position and attack_range == true and attack_cooldown == true:
			#player.position.x += knockback * delta

#cooldown node
func _on_cooldown_timeout():
	attack_cooldown = false

#handles enemy death. Essentially deletes the sprite off the scene if hp = 0 or less
func death():
	if ENEMY_HP <= 0:
		global.PLAYER_HP += 50
		queue_free()

#links enemy healthbar GUI to ENEMY_HP
func enemy_healthbar():
	var enemy_heathbar_parameters = $enemy_health
	enemy_heathbar_parameters.value = ENEMY_HP

#to sync animation and attack
func _on_pre_attack_enemy_cooldown_timeout():
	enemy_attack()

#to handle attacks to the left and be seperate from the right
func _on_enemy_hitbox_left_body_entered(body):
	if body.has_method("hero"):
		attack_range_left = true
		if attack_range_left == true:
			attack_cooldown_left = false
		if attack_cooldown_left == false and attack_range_left == true:
			$pre_attack_enemy_cooldown_left.start()

#to handle attacks to the left and be seperate from the right
func _on_enemy_hitbox_left_body_exited(body):
	if body.has_method("hero"):
		attack_range_left = false

#to handle attacks to the left and be seperate from the right
func _on_pre_attack_enemy_cooldown_left_timeout():
	enemy_attack_left()

#to handle attacks to the left and be seperate from the right
func _on_cooldown_left_timeout():
	attack_cooldown_left = false
