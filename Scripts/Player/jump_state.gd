class_name JumpState
extends State

func enter() -> void:
	motor.set_direction()
	motor.jump()
