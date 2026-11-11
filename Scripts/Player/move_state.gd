class_name MoveState
extends State


func enter() -> void:
	entity_owner.animation_player.play("walk")

func update(delta : float) -> void:
	if Input.get_axis("move_left", "move_right") == 0:
		transitioned.emit("idle")
		return
	
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("jump")
		return

func fixed_update(delta : float) -> void:
	motor.set_direction()
	motor.move()

func exit() -> void:
	entity_owner.animation_player.stop()
