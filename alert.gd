extends Control




func _on_yes_pressed():
	get_tree().change_scene_to_file("res://main menu.tscn")


func _on_no_pressed():
	get_tree().change_scene_to_file("res://scene.tscn")
