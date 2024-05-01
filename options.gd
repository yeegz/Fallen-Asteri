class_name OptionsMenu
extends Control

@onready var exit_button=$MarginContainer/VBoxContainer/Exit_Button as  Button

signal exit_options_menu


func _ready():
	
	set_process(false)
	



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main menu.tscn")
