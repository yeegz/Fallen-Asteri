extends Area2D


func _on_body_entered(body):
	if body.has_method("hero"):
		get_tree().change_scene_to_file("res://forest.tscn")


func _on_body_exited(body):
	if body.has_method("hero"):
		pass
