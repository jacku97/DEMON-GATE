class_name IdleEnemyState
extends State

@export var transition_state : String

func enter() -> void:
	transitioned.emit(transition_state)
