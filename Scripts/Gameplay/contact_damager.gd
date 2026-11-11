class_name ContactDamager
extends Area2D

@export var damage : int = 1

signal hit

func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.health.take_damage(damage)
		var direction = owner.velocity.normalized().x
		body.motor.knockback(direction)
		hit.emit()
