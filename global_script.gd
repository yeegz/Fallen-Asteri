extends Node


@onready var transitioned = false
@onready var current_scene = "beach"

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


#scene 2
@onready var alive_status_s2 = true

#scene 3
@onready var sideboss_dead = false

