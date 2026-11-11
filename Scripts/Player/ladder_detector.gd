class_name LadderDetector
extends Node2D

var _current_ladder : Node2D = null
var _current_ladders : Array[Node2D] = []

signal ladder_detected

func get_ladder() -> Array:
	
	return _current_ladders


func _on_chest_high_body_entered(body: Node2D) -> void:
	_current_ladders.append(body)
	if _current_ladders.size() == 1:
		ladder_detected.emit()

func _on_chest_high_body_exited(body: Node2D) -> void:
	_current_ladders.erase(body)
