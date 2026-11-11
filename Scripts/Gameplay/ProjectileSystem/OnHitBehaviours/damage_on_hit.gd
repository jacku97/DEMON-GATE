class_name DamageOnHit
extends OnHitBehaviour

@export var damage : int

func perform(context : Dictionary) -> void:
	if context["collider"] is Entity: 
		var e : Entity = context["collider"]
		e.health.take_damage(damage)
		var direction = owner_projectile._velocity.normalized().x
		e.motor.knockback(direction)
