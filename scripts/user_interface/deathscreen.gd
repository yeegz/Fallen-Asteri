extends Node2D

@onready var  death_sound = $AudioStreamPlayer as AudioStreamPlayer


func _on_restart_pressed():
	global.PLAYER_HP = 200
	get_tree().change_scene_to_file(global.current_scene)



func _on_main_menu_pressed():
	global.PLAYER_HP += 200
	get_tree().change_scene_to_file("res://Scenes/user_interface/main menu.tscn")
