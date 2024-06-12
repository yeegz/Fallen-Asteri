extends Node2D

var pos_x = 1878
var pos_y = 853
@onready var player = $CharacterBody2D

func _physics_process(delta):
	if global.transitioned == true:
		player.position.x = pos_x
		player.position.y = pos_y
		global.transitioned = false
