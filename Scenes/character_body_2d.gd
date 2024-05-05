extends CharacterBody2D

#variable declaration
const SPEED = 300
const JUMP = -550
var enemy = null
var GRAVITY_VALUE = 1100
var PLAYER_HP = 100
var PLAYER_STAMINA = 100
var player_attack_range = false
var player_attack_cooldown = true
@onready var animation = $AnimatedSprite2D

#main function
func _process(delta):
	var control = controls(delta)
	var grav = gravity(delta)
	var anim = animations(control)
	player_attack()
	print(PLAYER_STAMINA)

#Easiest way for enemy hitbox to idintify player is through methods. Creating throwaway
#function temporarily
func hero():
	pass

#player controls and sprite flipping according to direction
func controls(delta):
	#Added buttons A and D to the left and right axis respectively
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP
	
	#Movement. 
	if direction:
		velocity.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite2D.flip_h = false
		elif direction == -1:
			$AnimatedSprite2D.flip_h = true
	elif direction == 0 or velocity.x == 0:
		
		#requires move_towards to enable stopping movement
		velocity.x  = move_toward(1, 0, delta)
	
	#move_and_slide required for basic physics functions to work
	move_and_slide()
	return direction

#basic gravity
func gravity(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_VALUE * delta

#animations
func animations(control):
	#Animation
	if control and velocity.y == 0:
		animation.play("run")
	elif velocity.y != 0:
		animation.play("jump")
	elif control == 0 or velocity.x == 0:
		animation.play("idle")


func _on_player_attack_range_body_entered(body):
	if body.has_method("enemy"):
		enemy = body
		player_attack_range = true


func _on_player_attack_range_body_exited(body):
	if body.has_method("enemy"):
		enemy = null
		player_attack_range = false

func player_attack():
	var stamina_requirement = 30
	if Input.is_action_just_pressed("ui_attack") and player_attack_range == true and player_attack_cooldown == true and PLAYER_STAMINA > stamina_requirement:
		enemy.ENEMY_HP -= 20
		PLAYER_STAMINA -= stamina_requirement
		player_attack_cooldown = false
		$player_cooldown.start()
		if PLAYER_STAMINA < 100:
			$player_stamina.start()


func _on_player_cooldown_timeout():
	player_attack_cooldown = true


func _on_player_stamina_timeout():
	PLAYER_STAMINA += 10


