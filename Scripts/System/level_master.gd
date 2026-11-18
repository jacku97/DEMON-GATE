class_name LevelMaster
extends Node2D

@export var starting_scene : PackedScene

var current_level : LevelController
var next_position : Vector2 = Vector2.ZERO
var SCREEN_HEIGHT : float = 0
var cam : Camera2D

signal starting_advance
signal advance_finished

func setup() -> void:
	var screen :  Rect2 = get_viewport().get_canvas_transform().affine_inverse() * get_viewport().get_visible_rect()
	SCREEN_HEIGHT = screen.end.y
	cam = get_viewport().get_camera_2d()

func restart_game() -> void:
	if get_child_count() > 0:
		for child in get_children():
			child.queue_free()
	cam.global_position = Vector2.ZERO
	next_position = Vector2.ZERO
	var first_level := load_level(starting_scene)
	current_level = first_level
	add_level(first_level)
	add_level(load_level(starting_scene))

func build_world() -> void:
	#Build a chain of levels for current world
	pass

func start_level() -> void:
	current_level.start_level()

func get_player_spawn() -> Vector2:
	if current_level == null : return Vector2.ZERO
	return current_level.get_spawn_point()

func load_level(scene : PackedScene) -> LevelController:
	if scene == null : return
	var l = scene.instantiate()
	if l is not LevelController : return
	
	return l

func add_level(level : LevelController) -> void:
	add_child(level)
	level.setup()
	level.global_position = next_position
	next_position.y += SCREEN_HEIGHT
	level.advancer_crossed.connect(advance_level)

func advance_level():
	var p := cam.global_position
	p.y += SCREEN_HEIGHT
	tween_camera(p)
	starting_advance.emit()

func tween_camera(pos : Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(cam, "global_position", pos, 1)
	await tween.finished
	advance_finished.emit()

func on_game_over() -> void:
	current_level.on_game_over()
