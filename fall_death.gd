extends Area2D

var player = null

func _on_body_entered(body):
	if body.has_method("hero"):
		player = body


func _on_body_exited(body):
	if body.has_method("hero"):
		player = null

func _physics_process(delta):
	if player != null:
		global.PLAYER_HP = 0
