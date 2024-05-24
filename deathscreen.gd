extends Node2D

@onready var  death_sound = $AudioStreamPlayer as AudioStreamPlayer


func _on_restart_pressed():
	global.PLAYER_HP = 200
	if global.current_scene == "beach":
		get_tree().change_scene_to_file("res://scene.tscn")
	elif global.current_scene == "forest":
		get_tree().change_scene_to_file("res://forest.tscn")
	elif global.current_scene == "caves":
		get_tree().change_scene_to_file("res://caveboss.tscn")



func _on_quit_pressed():
	get_tree().quit()

func music():
	death_sound.play()

func _physics_process(delta):
	music()
