class_name ProjectileBase
extends Node2D

@export var speed  : float = 100
@export var wrap_padding : float = 8
@onready var _sprite_2d: Sprite2D = $Sprite2D
@onready var projectile_body: Area2D = %ProjectileBody

var _movement_behaviours : Array[MoveBehaviour]
var _on_hit_behaviours : Array[OnHitBehaviour]
var _detector : ShapeCast2D
var _velocity : Vector2
var _enabled : bool = false
var _last_collision : Object

func _physics_process(delta: float) -> void:
	if !_enabled : return
	_calculate_velocity(delta)
	if _check_collision(delta): return
	_move(delta)
	_wrap_around_screen()
	_set_sprite_direction()

func _wrap_around_screen() -> void:
	var screen = get_viewport().get_visible_rect()
	global_position.x = wrapf(
		global_position.x,
		screen.position.x - wrap_padding,
		screen.end.x + wrap_padding
	)


func setup() -> void:
	_setup_move_behaviours()
	_setup_collision_detector()
	_setup_on_hit_behaviours()
	_enabled = true
	

func _setup_move_behaviours() -> void:
	var movement = %MovementBehaviour
	if movement == null: return
	var childs = movement.get_children()
	if childs.size() < 1 : return
	for c in childs:
		c.setup(self)
		_movement_behaviours.append(c)

func _setup_on_hit_behaviours() -> void:
	var on_hit = %OnHitBehaviour
	if on_hit == null : return
	var childs = on_hit.get_children()
	if childs.size() < 1 : return
	for c : OnHitBehaviour in childs:
		c.setup(self)
		_on_hit_behaviours.append(c)

func _setup_collision_detector() -> void:
	%CollisionDetector.add_exception(%ProjectileBody)
	_detector = %CollisionDetector

func launch(initial_position : Vector2, initial_direction : float) -> void:
	global_position = initial_position
	var dir = Vector2(initial_direction, 0)
	_velocity = dir * speed


func _calculate_velocity(delta : float) -> void:
	_velocity = Vector2(_velocity.normalized().x, 0)
	for behaviour in _movement_behaviours:
		_velocity += behaviour.get_force(delta)
	_velocity *= speed


func _check_collision(delta : float) -> bool:
	if _detector == null : return false
	_detector.target_position = to_local(global_position + _velocity * delta)
	_detector.force_shapecast_update()
	if _detector.is_colliding():
		var context : Dictionary = {"collision" : _detector.collision_result,
									"point" : _detector.get_collision_point(0),
									"collider" : _detector.get_collider(0),
									"normal" : _detector.get_collision_normal(0)}
		if context["collider"] == _last_collision : return false
		_last_collision = context["collider"]
		_on_collision(context)
		return true
	else:
		return false

func _on_collision(context : Dictionary) -> void:
	global_position = context["point"]
	for behaviour in _on_hit_behaviours:
		print_debug(behaviour.name)
		behaviour.perform(context)

func _move(delta : float) -> void:
	global_position += _velocity * delta

func _set_sprite_direction() -> void:
	var dir = sign(_velocity.normalized().x) * 1

	if dir < 0:
		_sprite_2d.flip_h = true
	elif dir > 0:
		_sprite_2d.flip_h = false

func die() -> void:
	queue_free()
