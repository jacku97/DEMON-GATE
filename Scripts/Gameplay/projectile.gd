class_name Projectile
extends CharacterBody2D

@export var projectile_id : String
@export var speed : float = 100
@export var damage : int = 1
@export var wrap_padding : float = 8
var direction : float = 1
@onready var damager: Damager = $Damager
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func setup(new_direction : float) -> void:
	await ready
	damager.setup(damage, self)
	direction = new_direction

func _process(delta: float) -> void:
	var dir = sign(velocity.normalized().x) * 1

	if dir < 0:
		sprite_2d.flip_h = true
	elif dir > 0:
		sprite_2d.flip_h = false

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	move_and_slide()
	_wrap_around_screen()

func _wrap_around_screen() -> void:
	var screen = get_viewport().get_visible_rect()
	global_position.x = wrapf(
		global_position.x,
		screen.position.x - wrap_padding,
		screen.end.x + wrap_padding
	)

func die() -> void:
	queue_free()
