extends Control


@onready var option_button= $HBoxContainer/OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Fullscreen"
]

func add_window_mode_items_():
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)


func _ready():
	option_button.item_selected.connect(on_window_mode_selected)
	add_window_mode_items_()
	
	
func on_window_mode_selected(index : int) -> void:
	match index:
		1 : #Fullscreen 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2 : #Fullscreen 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		3 : #Fullscreen 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		4 : #Fullscreen 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
			
