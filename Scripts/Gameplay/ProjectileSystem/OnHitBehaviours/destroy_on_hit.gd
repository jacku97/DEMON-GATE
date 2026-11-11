class_name DestroyOnHit
extends OnHitBehaviour


func perform(context : Dictionary) -> void:
	owner_projectile.hide()
	await get_tree().physics_frame
	owner_projectile.queue_free()
