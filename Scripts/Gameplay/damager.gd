class_name Damager
extends Area2D

var damage : int
var projectile_owner : Projectile

func setup(new_dam : int, new_projectile) -> void:
	monitoring = true
	monitorable = true
	damage = new_dam
	projectile_owner = new_projectile


func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.health.take_damage(damage)
		var direction = projectile_owner.velocity.normalized().x
		body.motor.knockback(direction)
	if body != projectile_owner:
		if body is Projectile:
			body.die()
		monitoring = false
		monitorable = false
		owner.die()
