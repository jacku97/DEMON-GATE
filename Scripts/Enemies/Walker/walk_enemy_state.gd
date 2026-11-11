class_name WalkEnemyState
extends State
@onready var contact_damager: ContactDamager = %ContactDamager
@export var climb_chance : float = 80
@onready var ground_checker: GroundChecker = %GroundChecker
var dir : float = -1

func enter() -> void:
	motor.reset_velocity()
	contact_damager.hit.connect(change_direction)
	ladder_detector.ladder_detected.connect(on_ladder_detected)
	
	if ground_checker.check_left():
		dir = -1
	else:
		dir = 1
	motor.hard_set_direction(dir)
	ground_checker.no_ground_ahead.connect(change_direction)

func fixed_update(delta : float) -> void:
	ground_checker.check_ground()
	motor.hard_set_direction(dir)
	motor.move()

func change_direction() -> void:
	dir = -dir

func on_ladder_detected() -> void:
	
	var roll = randf_range(1,100)
	if roll < climb_chance:
		transitioned.emit("climb")

func exit() -> void:
	contact_damager.hit.disconnect(change_direction)
	ladder_detector.ladder_detected.disconnect(on_ladder_detected)
	ground_checker.no_ground_ahead.disconnect(change_direction)
