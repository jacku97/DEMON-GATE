class_name EnemySpawner
extends Node2D

@export var dont_spawn : bool = false
@export var enemies : Dictionary [PackedScene, float]
@export var spawn_time : float
var finished : float
var active : bool = false
signal game_reset

func _ready() -> void:
	finished = Time.get_ticks_msec() / 1000 + spawn_time


func spawn_enemy() -> void:
	if dont_spawn : return
	var total : float = 0
	for value in enemies.values():
		total += value
	var n = randf_range(0,total)
	for key in enemies.keys():
		if total <= enemies[key]:
			var e : EnemyEntity = key.instantiate()
			get_tree().current_scene.add_child(e)
			e.global_position = global_position
			e.setup()
			game_reset.connect(e.on_health_depleted)
	finished = Time.get_ticks_msec() / 1000 + spawn_time

func on_game_reset() -> void:
	active = true
	finished = Time.get_ticks_msec() / 1000 + spawn_time


func on_game_over() -> void:
	active = false
	game_reset.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() / 1000 > finished and active:
		spawn_enemy()
