class_name Health
extends Node

@export var starting_health : int = 5
var current_health : int
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var entity_owner : Entity
@onready var motor: Motor = %Motor
@onready var statemachine: Statemachine = %Statemachine

signal health_updated(value : int)
signal died

func setup(new_owner : Entity) -> void:
	current_health = starting_health
	health_updated.emit(current_health)
	entity_owner = new_owner

func take_damage(to_take : int) -> void:
	current_health -= to_take
	current_health = max(current_health,0)
	health_updated.emit(current_health)
	if current_health == 0:
		die()
		return
	
	if animation_player != null:
		animation_player.play("hurt")

func die() -> void:
	if animation_player != null:
		animation_player.stop()
	await get_tree().create_timer(0.1).timeout
	died.emit()
