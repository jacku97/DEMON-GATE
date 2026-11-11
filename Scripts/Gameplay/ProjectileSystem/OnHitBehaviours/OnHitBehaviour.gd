class_name OnHitBehaviour
extends Node

var owner_projectile : ProjectileBase


func setup(new_owner : ProjectileBase) -> void:
	owner_projectile = new_owner

func perform(context : Dictionary) -> void:
	pass
