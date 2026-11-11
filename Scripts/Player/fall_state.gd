class_name FallState
extends State

var starting_y: float

func enter() -> void:
	starting_y = entity_owner.global_position.y
	
func update(delta : float) -> void:
	var y_vel := entity_owner.velocity.y
	if sign(y_vel) == -1:
		entity_owner.animation_player.play("airup")
	else:
		entity_owner.animation_player.play("airdown")
	
	if entity_owner.is_on_floor():
		if abs(entity_owner.global_position.y - starting_y) > 100 :
			entity_owner.health.take_damage(1)
			transitioned.emit("stunnedfall")
			return
		
		transitioned.emit("idle")
		return

func fixed_update(delta : float) -> void:
	motor.apply_gravity(delta)
	for i in entity_owner.get_slide_collision_count():
		var collision = entity_owner.get_slide_collision(i)
		var normal = collision.get_normal()
		
		if abs(normal.x) > 0.7:
			motor.knockback(normal.normalized().x)
