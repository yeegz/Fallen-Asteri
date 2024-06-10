extends Camera2D

func _process(delta):
	camera_tracking()

func camera_tracking():
	position = global.PLAYER_POSITION
