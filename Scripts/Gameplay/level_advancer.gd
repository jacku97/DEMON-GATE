class_name LevelAdvancer
extends Node2D

signal advance
var active : bool = false


func deactivate() -> void:
	active = false

func activate() -> void:
	active = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if active == false : return
	
	if body is Entity:
		advance.emit()
