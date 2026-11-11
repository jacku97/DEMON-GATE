class_name MoveBehaviour
extends Node

@export var weight : float = 1

var owner_projectile : ProjectileBase


func setup(new_owner : ProjectileBase) -> void:
	owner_projectile = new_owner

func get_force(delta : float) -> Vector2:
	return Vector2.ZERO
