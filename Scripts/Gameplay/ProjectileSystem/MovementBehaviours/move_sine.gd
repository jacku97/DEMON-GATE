class_name MoveSine
extends MoveBehaviour

@export var frequency : float = 5
@export var amplitude : float = 5

var _time_passed : float = 0
var _initial_y : float = 0

func setup(new_owner : ProjectileBase) -> void:
	super.setup(new_owner)
	_initial_y = owner_projectile.global_position.y

func get_force(delta : float) -> Vector2:
	var y : float = _initial_y
	_time_passed += delta
	y += sin(_time_passed * frequency) * amplitude
	var force : Vector2 = Vector2(0, y)
	return force * weight
	
