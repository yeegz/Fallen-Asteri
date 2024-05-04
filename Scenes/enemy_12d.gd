extends CharacterBody2D

const GRAVITY_VALUE = 1100
var SPEED = 70
var JUMP = -500
var ENEMY_HP = 100
var player = null
var player_chase = false
var attack_range = false
var attack_cooldown = true
var player_alive = true
@onready var animation = $AnimatedSprite2D


func _physics_process(delta):
	var grav = gravity(delta)
	enemy_attack()
	var anim = animations(player_chase)
	var path = pathing(player_chase, delta, SPEED, JUMP)

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


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("hero"):
		attack_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("hero"):
		attack_range = false

func enemy_attack():
	if attack_range == true and attack_cooldown == true:
		player.PLAYER_HP -= 20 
		attack_cooldown = false
		$cooldown.start()
		print(player.PLAYER_HP)

func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	move_and_slide()

func animations(player_chase):
	#Animation
	if player_chase == false:
		animation.play("crab_idle")
	elif attack_range == true:
		animation.play("crab_attack")

func pathing(player_chase, delta, SPEED, JUMP):
	if player_chase == true:
		#move towards player if in detection area
		position += (player.position - position)/ SPEED
		#to prevent enemy from sliding
		move_toward(1, 0, delta)
		
		#Flip sprite according to direction
		if player.position < position:
			$AnimatedSprite2D.flip_h = false
		elif player.position > position:
			$AnimatedSprite2D.flip_h = true
		
		#jumping func
		if not player.is_on_floor() and is_on_floor():
			velocity.y = JUMP


func _on_cooldown_timeout():
	attack_cooldown = true


func end_screen():
	if player.PLAYER_HP <= 0:
		player_alive = false #endscreen for later
