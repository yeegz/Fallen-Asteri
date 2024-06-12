extends CanvasLayer

@export (String, FILE, "*.json") var d_file

var dialogue = []

func _ready():
	start()
func start():
	dialogue = load_dialogue() 
	
	$NinePatchRect/name.text = dialogue[0]['name']
	$NinePatchRect/chat.text = dialogue[0]['text']
	
func load_dialogue():
	var file = File.new()
	if file.file_exists(d_file):
		file.open(d_file, file.READ)
		return parse_json(file.get_as_text())
