class_name LevelController
extends Node2D
var player_spawn: Node2D 
var enemy_spawner: EnemySpawner 
var kill_box : Killbox


func setup() -> void:
	player_spawn = $PlayerSpawn
	enemy_spawner = $EnemySpawner
	kill_box = $Killbox

func get_spawn_point () -> Vector2:
	if player_spawn == null : Vector2.ZERO
	return player_spawn.global_position

func start_level() -> void:
	enemy_spawner.on_game_reset()
	#kill_box.set_enable(true)

func on_game_over() -> void:
	enemy_spawner.on_game_over()

func on_level_finished() -> void:
	kill_box.set_enable(false)
