extends CharacterBody2D

const SPEED = 30
const JUMP = 30
var GRAVITY_VALUE = 980




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
		move_and_slide()

