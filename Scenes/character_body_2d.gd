extends CharacterBody2D

const SPEED = 300
const JUMP = -550
var GRAVITY_VALUE = 1100




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP
	
	#Added buttons A and D to the left and right axis respectively
	var direction = Input.get_axis("ui_left", "ui_right")
	#Movement. Note: character doesn't stop moving in one direction until opposite button
	#is pressed.
	if direction:
		velocity.x = SPEED * direction
		if direction == 1:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		#requires move_towards to enable stopping movement
		velocity.x  = move_toward(1, 0, 1)
	
	
	
	
	move_and_slide()

