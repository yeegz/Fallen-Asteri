extends CharacterBody2D

var GRAVITY_VALUE = 1100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	
	move_and_slide()
