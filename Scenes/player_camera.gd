extends Camera2D

var scene = global.current_scene

func _process(delta):
	camera_tracking()

func camera_tracking():
	position = global.PLAYER_POSITION
	if scene == "res://scene.tscn":
		#x position
		if position.x <= 13:
			position.x = 13
		elif position.x >= 1097.9:
			position.x = 1097.9
		
		#y position
		if position.y <= 74:
			position.y = 74
		
	elif scene == "res://forest.tscn":
		#x position
		if position.x <= 607:
			position.x = 607
		elif position.x >= 1981:
			position.x = 1981
		
		#y position
		if position.y >= 860:
			position.y = 860
		
	elif scene == "res://caveboss.tscn":
		#x position
		if position.x <= 617:
			position.x = 617
		elif position.x >= 1508 and global.sideboss_dead == false:
			position.x = 1508
		elif position.x >= 1411 and global.sideboss_dead == true:
			position.x = 1411
		
	elif scene == "res://cloudlevel.tscn":
		if position.x <= 364:
			position.x = 364
		elif position.x >= 1559:
			position.x = 1559
		
		if position.y >= 866:
			position.y = 866
		
	elif scene == "res://2ndboss.tscn":
		if position.x <= 525:
			position.x = 525
		elif position.x >= 475:
			position.x = 475
		
		if position.y >= 537:
			position.y = 537
