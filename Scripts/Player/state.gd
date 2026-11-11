class_name State
extends Node


@export var trigger_falling : bool = true
@export var trigger_shooting : bool = false


var process : bool = true
var entity_owner : Entity
var motor : Motor
var weapons : WeaponsHandler
var ladder_detector : LadderDetector
signal transitioned(new_state : String)


func setup(new_owner : Entity, new_motor : Motor, new_wep_handler : WeaponsHandler, new_ladder_detector : LadderDetector) -> void:
	entity_owner = new_owner
	motor = new_motor
	weapons = new_wep_handler
	ladder_detector = new_ladder_detector

func enter() -> void:
	pass

func fall_check() -> void:
	if !trigger_falling : return
	if !entity_owner.is_on_floor():
		transitioned.emit("fall")
		return

func shoot_check() -> void:
	if !trigger_shooting : return
	if Input.is_action_just_pressed("shoot_1") and weapons.projectile_1.current_projectile != null:
		transitioned.emit("shoot")
		return
	if  Input.is_action_just_pressed("shoot_2") and weapons.projectile_2.current_projectile != null:
		transitioned.emit("shoot")
		return

func update(delta : float) -> void:
	pass

func fixed_update(delta : float) -> void:
	pass

func exit() -> void:
	pass
