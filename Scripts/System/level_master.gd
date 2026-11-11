class_name LevelMaster
extends Node2D

@export var starting_scene : PackedScene

var current_level : LevelController
var next_position : Vector2 = Vector2.ZERO
var SCREEN_HEIGHT : float = 0


func setup() -> void:
	var screen :  Rect2 = get_viewport().get_canvas_transform().affine_inverse() * get_viewport().get_visible_rect()
	SCREEN_HEIGHT = screen.end.y

func restart_game() -> void:
	if get_child_count() > 0:
		for child in get_children():
			child.queue_free()
	get_viewport().get_camera_2d().global_position = Vector2.ZERO
	next_position = Vector2.ZERO
	var first_level := load_level(starting_scene)
	current_level = first_level
	add_level(first_level)
	add_level(load_level(starting_scene))
	add_level(load_level(starting_scene))
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

func advance_level():
	#Tween the camera
	#Delete previous level
	#Signal that the level is ready
	pass

func tween_camera() -> void:
	pass

func on_game_over() -> void:
	current_level.on_game_over()
