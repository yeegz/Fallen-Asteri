extends Area2D

var player = null
var player_posx_on_transition = 1545
var player_posy_on_transition = 157
var scene = "res://forest.tscn"

func _on_body_entered(body):
	if body.has_method("hero"):
		player = body
		


func _on_body_exited(body):
	if body.has_method("hero"):
		player = null


func _physics_process(delta):
	if player != null:
		global.current_scene = scene
		get_tree().change_scene_to_file(scene)
