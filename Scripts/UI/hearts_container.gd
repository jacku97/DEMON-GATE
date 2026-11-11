class_name HeartsContainer
extends HBoxContainer

@export var heart_full : Texture2D
@export var heart_empty : Texture2D


func update_health(value : int) -> void:
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
