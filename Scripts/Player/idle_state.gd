class_name IdleState
extends State

func enter() -> void:
	entity_owner.animation_player.play("RESET")
	if Input.get_axis("move_left", "move_right") != 0:
		transitioned.emit("move")
	motor.reset_velocity()
	
func update(delta : float) -> void:
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("jump")
		return
	
	
	if Input.get_axis("move_left", "move_right") != 0:
		transitioned.emit("move")
		return
	
	if Input.is_action_just_pressed("climb_up") and ladder_detector.get_ladder().size() != 0:
		transitioned.emit("climb")
		return
	
	if Input.is_action_just_pressed("climb_down") and ladder_detector.get_ladder().size() != 0:
		transitioned.emit("climb")
		return
