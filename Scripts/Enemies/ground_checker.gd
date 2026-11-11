class_name GroundChecker
extends Node2D

var entity_owner : Entity
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var enabled : bool = false
signal no_ground_ahead

func setup(new_owner : Entity) -> void:
	entity_owner = new_owner
	enabled = true

func check_left() -> bool:
	ray_cast_2d.global_position = entity_owner.global_position + (Vector2(50,0) * - 1)
	ray_cast_2d.force_raycast_update()
	if !ray_cast_2d.is_colliding():
		return false
	return true

func check_ground() -> void:
	ray_cast_2d.global_position = entity_owner.global_position + (Vector2(25,0) * entity_owner.facing_direction)
	ray_cast_2d.force_raycast_update()
	if !ray_cast_2d.is_colliding():
		no_ground_ahead.emit()
