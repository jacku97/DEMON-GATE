class_name StunnedFallState
extends State

var bounced : bool = false
var starting_y : float

func enter() -> void:
	entity_owner.animation_player.play("stunnedfall")
	starting_y = entity_owner.global_position.y
	bounced = false

func fixed_update(delta : float) -> void:
	motor.apply_gravity(delta)

func update(delta : float) -> void:
	if entity_owner.is_on_floor():
		if !bounced:
			if abs(entity_owner.global_position.y - starting_y) > 100 :
				entity_owner.health.take_damage(1)
			motor.bounce()
			bounced = true
		else:
			if abs(entity_owner.global_position.y - starting_y) > 100 :
				entity_owner.health.take_damage(1)
				motor.bounce()
				starting_y = entity_owner.global_position.y
				return
			transitioned.emit("stunned")
			return
	
