'''extends Resource
class_name PlayerData

@export var transitioned = global.transitioned
@export var current_scene = global.current_scene

#Player variables
@export var PLAYER_HP = global.PLAYER_HP
@export var PLAYER_MAX_HP = global.PLAYER_MAX_HP
@export var PLAYER_STAMINA = global.PLAYER_STAMINA
@export var PLAYER_MAX_STAMINA = global.PLAYER_MAX_STAMINA
@export var PLAYER_XP = global.PLAYER_XP
@export var PLAYER_ATTACK_DAMAGE = global.PLAYER_ATTACK_DAMAGE

#scene 1
@export var alive_status_s1 = global.alive_status_s1
@export var ENEMY_S1_XP = global.SKELETON_ENEMY_XP_DROP

#scene 2
@export var alive_status_s2 = global.alive_status_s2
@export var ENEMY_S2_XP = global.SKELETON_ENEMY_XP_DROP

@export var SavePos:Vector2


#func UpdatePos(value : Vector2):
	#SavePos = value
'''
