extends CharacterBody2D

#variable declaration
const GRAVITY_VALUE = 1100
var SPEED = 70
var JUMP = -500
@onready var ENEMY_HP = 60
var player = null
var player_chase = false
var attack_range = false
var attack_range_left = false
var attack_cooldown = true
var attack_cooldown_left = true
var player_alive = true
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	pass

func enemy():
	pass


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
