extends Node2D

@onready var  death_sound = $AudioStreamPlayer as AudioStreamPlayer


func _on_restart_pressed():
	global.PLAYER_HP = 200
	get_tree().change_scene_to_file(global.current_scene)





func music():
	death_sound.play()

func _physics_process(delta):
	music()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://main menu.tscn")
