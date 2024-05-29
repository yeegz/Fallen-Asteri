extends CharacterBody2D

#variable declaration
const GRAVITY_VALUE = 1100

func _physics_process(delta):
	gravity(delta)

func enemy():
	pass

func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	move_and_slide()
