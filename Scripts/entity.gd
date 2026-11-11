class_name Entity
extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var facing_direction : float = 1
@onready var health: Health = $Health
@onready var motor: Motor = %Motor
@onready var statemachine: Statemachine = %Statemachine
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var weapons: WeaponsHandler = %Weapons

@export var manual_setup : bool = false

var active : bool = true


signal dead



func setup() -> void:
	active = false
	set_collision_mask_value(1, true)
	set_collision_mask_value(8, true)
	facing_direction = -1
	motor.reset_velocity()
	health.setup(self)
	if !health.died.is_connected(on_health_depleted):
		health.died.connect(on_health_depleted)
	statemachine.setup(self)
	if weapons != null:
		weapons.setup()
	active = true
	

func _process(delta: float) -> void:
	var dir = sign(velocity.normalized().x) * 1
	if dir != 0:
		facing_direction = dir
	if dir < 0:
		sprite_2d.flip_h = true
	elif dir > 0:
		sprite_2d.flip_h = false

func on_health_depleted() -> void:
	set_collision_mask_value(1, false)
	set_collision_mask_value(8, false)
	dead.emit()
