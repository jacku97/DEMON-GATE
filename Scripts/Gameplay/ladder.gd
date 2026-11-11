class_name Ladder
extends StaticBody2D

@onready var ladder_top: StaticBody2D = $LadderTop
@onready var ray_cast_2d: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray_cast_2d.force_raycast_update()
	await get_tree().physics_frame
	if ray_cast_2d.is_colliding():
		ladder_top.queue_free()
	
