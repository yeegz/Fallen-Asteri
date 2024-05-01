extends CharacterBody2D

const GRAVITY_VALUE = 1100
var SPEED = 50
var JUMP = 50
var player = null
var player_chase = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func _physics_process(delta):
	if player_chase == true:
		position += (player.position - position)/ SPEED
		if not player.is_on_floor() and not is_on_floor():
			velocity.y = JUMP

	
