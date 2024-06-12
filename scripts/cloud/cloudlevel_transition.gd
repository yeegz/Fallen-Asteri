extends Area2D

var player = null
var scene = "res://Scenes/forest/forest.tscn"



func _on_body_entered(body):
	if body.has_method("hero"):
		player = body


func _on_body_exited(body):
	if body.has_method("hero"):
		player = null

func _physics_process(delta):
	if player != null and global.sideboss_dead == true:
		global.transitioned = true
		global.current_scene = scene
		get_tree().change_scene_to_file(scene)
