class_name ClimbEnemyState
extends State

var dir : float = -1
@export var ladder_layer : int = 8

func enter() -> void:
	dir = -1
	entity_owner.set_collision_mask_value(ladder_layer, false)
	motor.reset_velocity()
	entity_owner.global_position.x = ladder_detector.get_ladder()[0].global_position.x
	if !ladder_detector.get_ladder()[0].global_position.y < entity_owner.global_position.y:
		dir = 1

func update(delta : float) -> void:
	if ladder_detector.get_ladder().size() == 0:
		transitioned.emit("idle")
		return
	if entity_owner.is_on_floor() and ladder_detector.get_ladder().size() < 2:
		transitioned.emit("idle")
		return

func fixed_update(delta : float) -> void:
	motor.enemy_climb_up(dir)

func exit() -> void:
	entity_owner.set_collision_mask_value(ladder_layer, true)
