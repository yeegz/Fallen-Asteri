extends Control

signal start_game()
@onready var buttons_v_box=%Buttons_v_box as Button
@onready var options_menu= $Options_Menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer

func _ready()->void:
	focus_button()
	
func _on_start_game_button_pressed() -> void:
	start_game.emit()
	hide()
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	if visible:
		focus_button()
		
		
func focus_button()-> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()
			

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(false) 
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scene.tscn")
	
func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
  
func _on_quit_pressed():
	get_tree().quit()
	
	
func handle_connecting_signals() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://options.tscn")
