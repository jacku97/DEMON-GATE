class_name MoveUp
extends MoveBehaviour


func get_force(delta : float) -> Vector2:
	return Vector2.UP * weight
