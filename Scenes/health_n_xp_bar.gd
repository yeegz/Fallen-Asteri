extends Camera2D

#function to link healthbar GUI to PLAYER_HP
func healthbar():
	var healthbar_parameters = $health
	healthbar_parameters.max_value = global.PLAYER_MAX_HP
	healthbar_parameters.value = global.PLAYER_HP
	if global.PLAYER_HP > global.PLAYER_MAX_HP:
		global.PLAYER_HP = global.PLAYER_MAX_HP

func xpbar():
	var xpbar_parameters = $XPbar
	xpbar_parameters.max_value = global.PLAYER_MAX_XP
	xpbar_parameters.value = global.PLAYER_XP

func _process(delta):
	healthbar()
	xpbar()
