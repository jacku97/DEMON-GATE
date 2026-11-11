class_name Motor
extends Node

var owner_entity : Entity 
var direction : float = 0
@export var GROUND_SPEED : float = 150.0
@export var AIR_SPEED : float = 400.0
@export var JUMP_VELOCITY : float = -300.0
@export var KNOCKBACK_POWER : float = 250.0
@export var CLIMB_SPEED : float = 100
@export var wrap_padding : float = 8.0

@onready var statemachine: Statemachine = %Statemachine


func _ready() -> void:
	owner_entity = get_parent()

func setup() -> void:
	reset_velocity()

func _physics_process(delta: float) -> void:
	#direction = 0
	owner_entity.move_and_slide()
	if owner_entity.active == false:
		print_debug("Before: " + str(owner_entity.global_position.y) + " " + str(owner_entity.active))
	_wrap_around_screen()
	if owner_entity.active == false:
		print_debug("After " + str(owner_entity.global_position.y) + " " + str(owner_entity.active))
	

func hard_set_direction(dir : float) -> void:
	direction = dir

func set_direction() -> void:
	direction = Input.get_axis("move_left", "move_right")

func reset_velocity() -> void:
	owner_entity.velocity = Vector2.ZERO

func knockback(dir : float) -> void:
	owner_entity.velocity.x = KNOCKBACK_POWER * dir
	owner_entity.velocity.y = JUMP_VELOCITY
	statemachine.on_state_transitioned("stunnedfall")

func bounce() -> void:
	owner_entity.velocity.x = KNOCKBACK_POWER/2  * owner_entity.facing_direction
	owner_entity.velocity.y = JUMP_VELOCITY/2

func jump() -> void:
	owner_entity.velocity.x = AIR_SPEED  * direction
	owner_entity.velocity.y = JUMP_VELOCITY

func launch() -> void:
	owner_entity.velocity.x = AIR_SPEED * direction
	owner_entity.velocity.y = JUMP_VELOCITY 

func move() -> void:
	var move_speed : float = GROUND_SPEED
	if direction:
		owner_entity.velocity.x = direction * move_speed
	else:
		owner_entity.velocity.x = move_toward(owner_entity.velocity.x, 0, move_speed)

func _wrap_around_screen() -> void:
	var screen :  Rect2 = get_viewport().get_canvas_transform().affine_inverse() * get_viewport().get_visible_rect()
	owner_entity.global_position.x = wrapf(
		owner_entity.global_position.x,
		screen.position.x - wrap_padding,
		screen.end.x + wrap_padding
	)
	if owner_entity.active == false:
		owner_entity.global_position.y = wrapf(
		owner_entity.global_position.y,
		screen.position.y - wrap_padding,
		screen.end.y + wrap_padding
	)
	
func climb() -> void:
	var dir = Input.get_axis("climb_up", "climb_down")
	if dir:
		owner_entity.animation_player.play("climb")
		owner_entity.velocity.y = dir * GROUND_SPEED
	else:
		owner_entity.velocity.y = move_toward(owner_entity.velocity.y, 0, GROUND_SPEED)

func enemy_climb_up(dir : float) -> void:
	owner_entity.velocity.y = dir * CLIMB_SPEED

func apply_gravity(delta : float) -> void:
	owner_entity.velocity += owner_entity.get_gravity() * delta
