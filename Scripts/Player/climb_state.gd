class_name ClimbState
extends State
@export var ladder_layer : int = 8

func enter() -> void:
	entity_owner.set_collision_mask_value(ladder_layer, false)
	entity_owner.global_position.x = ladder_detector.get_ladder()[0].global_position.x

func update(delta : float) -> void:
	if Input.is_action_pressed("climb_down") and entity_owner.is_on_floor() and ladder_detector.get_ladder().size() < 3:
		print_debug("On floor")
		transitioned.emit("idle")
		return
	
	if ladder_detector.get_ladder().size() == 0:
		print_debug("no ladder")
		transitioned.emit("idle")
		return
	

func fixed_update(delta : float) -> void:
	motor.climb()

func exit() -> void:
	entity_owner.set_collision_mask_value(ladder_layer, true)
