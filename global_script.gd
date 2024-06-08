extends Node


@onready var transitioned = false
@onready var current_scene = "res://scene.tscn"
#Player variables
@onready var PLAYER_HP = 200
@onready var PLAYER_MAX_HP = 200
@onready var PLAYER_STAMINA = 100
@onready var PLAYER_MAX_STAMINA = 100
@onready var PLAYER_XP = 0
@onready var PLAYER_MAX_XP = 10
@onready var PLAYER_LEVEL = 1
@onready var PLAYER_ATTACK_DAMAGE = 20
@onready var STAMINA_RECOVERY = 10


#enemy variables

@onready var SKELETON_ENEMY_XP_DROP = 10
@onready var SIDEBOSS_XP_DROP = 20

#scene 1
@onready var alive_status_s1 = true
@onready var alive_status_s1_2 = true
@onready var alive_status_s1_3 = true


#scene 2
@onready var alive_status_s2 = true

#scene 3
@onready var sideboss_dead = false

#scene 4
@onready var alive_status_s4_1 = true
@onready var second_sideboss_xp_drop = 30

#save
var data = [transitioned, current_scene, PLAYER_HP, PLAYER_MAX_HP, PLAYER_STAMINA, PLAYER_MAX_STAMINA, PLAYER_XP, PLAYER_MAX_XP, PLAYER_LEVEL, PLAYER_ATTACK_DAMAGE, STAMINA_RECOVERY, SKELETON_ENEMY_XP_DROP, SIDEBOSS_XP_DROP, alive_status_s1, alive_status_s2, sideboss_dead, alive_status_s4_1, second_sideboss_xp_drop, alive_status_s1_2, alive_status_s1_3]



func _physics_process(delta):
	for x in range(0,2):
		data = [transitioned, current_scene, PLAYER_HP, PLAYER_MAX_HP, PLAYER_STAMINA, PLAYER_MAX_STAMINA, PLAYER_XP, PLAYER_MAX_XP, PLAYER_LEVEL, PLAYER_ATTACK_DAMAGE, STAMINA_RECOVERY, SKELETON_ENEMY_XP_DROP, SIDEBOSS_XP_DROP, alive_status_s1, alive_status_s2, sideboss_dead, alive_status_s4_1, second_sideboss_xp_drop, alive_status_s1_2, alive_status_s1_3]

func save(info):
	var file = FileAccess.open("user://save.txt",FileAccess.WRITE)
	file.store_var(info)


func load():
	var file = FileAccess.open("user://save.txt",FileAccess.READ)
	var info = file.get_var()
	current_scene = info[1]
	get_tree().change_scene_to_file(current_scene)
	transitioned = info[0]
	PLAYER_HP = info[2]
	PLAYER_MAX_HP  = info[3]
	PLAYER_STAMINA  = info[4]
	PLAYER_MAX_STAMINA = info[5]
	PLAYER_XP = info[6]
	PLAYER_MAX_XP = info[7]
	PLAYER_LEVEL = info[8]
	PLAYER_ATTACK_DAMAGE = info[9]
	STAMINA_RECOVERY = info[10]
	SKELETON_ENEMY_XP_DROP = info[11]
	SIDEBOSS_XP_DROP = info[12]
	alive_status_s1 = info[13]
	alive_status_s2 = info[14]
	sideboss_dead = info[15]
	alive_status_s4_1 = info[16]
	second_sideboss_xp_drop = info[17]
	alive_status_s1_2 = info[18]
	alive_status_s1_3 = info[19]


