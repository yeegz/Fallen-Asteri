extends Area2D

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		global.transitioned = true
		get_tree().change_scene_to_file("res://caveboss.tscn")


func _on_body_entered(body):
	if body.has_method("hero"):
		player = body


func _on_body_exited(body):
	if body.has_method("hero"):
		player = null
