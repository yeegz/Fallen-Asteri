extends Node


@export var transitioned = false
@export var current_scene = "beach"

#Player variables
@onready var PLAYER_HP = 200
@onready var PLAYER_MAX_HP = 200
@onready var PLAYER_STAMINA = 100
@onready var PLAYER_MAX_STAMINA = 100
@onready var PLAYER_XP = 0
@onready var PLAYER_ATTACK_DAMAGE = 20

#enemy variables


#scene 1
@onready var alive_status_s1 = true
@onready var ENEMY_S1_XP = 10

#scene 2
@onready var alive_status_s2 = true
@onready var ENEMY_S2_XP = 10

