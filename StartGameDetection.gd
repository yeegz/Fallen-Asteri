class_name Scenetrigger extends Area2D

var entered = false


func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body):
	entered = false
	
