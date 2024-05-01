extends Area2D

var player = null
var player_chase = false
var SPEED = 250
var JUMP = -500

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/ SPEED
		print(position)

func _on_body_entered(body):
	player = body
	player_chase = true

func _on_body_exited(body):
	player = null
	player_chase = false

