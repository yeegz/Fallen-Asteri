extends Node2D

@onready var player = $CharacterBody2D
@onready var coordinates = $scene_transition

func _physics_process(delta):
	if global.transitioned == true:
		player.position.x = coordinates.player_posx_on_transition
		player.position.y = coordinates.player_posy_on_transition
		global.transitioned = false
		
		
