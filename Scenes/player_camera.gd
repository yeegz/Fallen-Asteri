extends Camera2D



func _process(delta):
	camera_tracking()

func camera_tracking():
	position = global.PLAYER_POSITION
	#x position
	if position.x <= 13:
		position.x = 13
	elif position.x >= 1097.9:
		position.x = 1097.9
	
	#y position
	if position.y <= 74:
		position.y = 74
