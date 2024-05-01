extends CharacterBody2D

const GRAVITY_VALUE = 1100
var SPEED = 250
var player = null
var player_chase = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta
	
	move_and_slide()


func _on_detection_area_body_entered(body):
	pass # Replace with function body.
	



func _on_detection_area_body_exited(body):
	pass # Replace with function body.
