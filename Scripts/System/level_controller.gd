class_name LevelController
extends Node2D
@onready var player_spawn: Node2D = %PlayerSpawn
@onready var enemy_spawner: EnemySpawner = %EnemySpawner



func get_spawn_point () -> Vector2:
	return %PlayerSpawn.global_position

func start_level() -> void:
	%EnemySpawner.on_game_reset()

func on_game_over() -> void:
	enemy_spawner.on_game_over()
