class_name Statemachine
extends Node

@export var initial_state : State
@onready var motor: Motor = %Motor
@onready var weapons: WeaponsHandler = %Weapons
@onready var ladder_detector: LadderDetector = %LadderDetector

var entity_owner : Entity
var current_state : State
var states : Dictionary = {}

func setup(new_owner : Entity) -> void:
	entity_owner = new_owner
	entity_owner.dead.connect(on_game_over)
	if states.size() > 0:
		states.clear()
	for child in get_children():
		if child is State:
			child = child as State
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_state_transitioned)
			child.setup(owner, motor, weapons, ladder_detector)
	change_state(initial_state)




func _process(delta: float) -> void:
	if entity_owner.active == false : return
	if !current_state : return
	if !current_state.process : return
	current_state.update(delta)
	current_state.shoot_check()

func _physics_process(delta: float) -> void:
	if entity_owner.active == false : return
	if !current_state : return
	if !current_state.process : return
	current_state.fall_check()
	current_state.fixed_update(delta)


func change_state(new_state : State) -> void:
	if new_state == current_state: return
	if current_state:
		current_state.exit()
	current_state = new_state
	
	current_state.enter()


func on_state_transitioned(new_state_name : String) -> void:
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	else:
		change_state(new_state)

func on_game_over() -> void:
	current_state.exit()
	current_state = null
