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
