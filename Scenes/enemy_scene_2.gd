extends CharacterBody2D

#variable declaration
const GRAVITY_VALUE = 1100
var SPEED = 70
var JUMP = -500
var ENEMY_HP = 60
var player = null
var player_chase = false
var attack_range = false
var attack_cooldown = true
@onready var animation = $AnimatedSprite2D

func enemy():
	pass

func _physics_process(delta):
	gravity(delta)
	pathing(player_chase, delta, SPEED)

func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

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



func _on_cooldown_right_timeout():
	pass # Replace with function body.


func _on_cooldown_left_timeout():
	pass # Replace with function body.


func _on_pre_attack_enemy_cooldown_right_timeout():
	pass # Replace with function body.


func _on_pre_attack_enemy_cooldown_left_timeout():
	pass # Replace with function body.
