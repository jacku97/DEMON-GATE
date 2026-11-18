class_name LevelController
extends Node2D
var player_spawn: Node2D 
var enemy_spawner: EnemySpawner 
var advancer : LevelAdvancer
var entrances_exits : EntrancesExits
var foreground_layer : TileMapLayer
signal advancer_crossed

@export var ladder_source_id : int = 0
@export var ladder_scene_id : int = 1

func setup() -> void:
	player_spawn = $PlayerSpawn
	enemy_spawner = $EnemySpawner
	advancer = $LevelAdvancer
	entrances_exits = $LevelEntrancesExits
	foreground_layer = $Foreground
	
	advancer.advance.connect(on_level_advance)
	advancer.deactivate()
	entrances_exits.deactivate()


func get_size_in_tiles() -> Vector2i:
	var tile_size := Vector2(foreground_layer.tile_set.tile_size)
	var design_size := get_viewport_rect().size
	var tiles := design_size / (tile_size * scale)
	assert(
		is_equal_approx(tiles.x, roundf(tiles.x)) and is_equal_approx(tiles.y, roundf(tiles.y)),
		"Screen size doesn't divide evenly into scaled tiles: %s" % tiles
	)
	return Vector2i(tiles.round())

func get_pixel_height() -> float:
	return get_size_in_tiles().y * foreground_layer.tile_set.tile_size.y * scale.y

func get_spawn_point () -> Vector2:
	if player_spawn == null : Vector2.ZERO
	return player_spawn.global_position

func _is_blocking(cell : Vector2i) -> bool:
	return foreground_layer.get_cell_source_id(cell) != -1

func _place_ladder(cell : Vector2i, scene_id : int) -> void:
	entrances_exits.set_cell(cell, ladder_source_id, Vector2i.ZERO, scene_id)

func apply_incoming_ladders(columns : Array[int]) -> void:
	var rows := get_size_in_tiles().y
	for x in columns:
		var last_row := -1
		for y in rows:
			var cell := Vector2i(x,y)
			if _is_blocking(cell):
				break
			_place_ladder(cell, ladder_scene_id)
			last_row = y
		
	entrances_exits.update_internals()

func get_outgoing_ladder_columns() -> Array[int]:
	var columns : Array[int] = []
	var size := get_size_in_tiles()
	var bottom_row := size.y - 1
	for x in size.x:
		if entrances_exits.get_cell_source_id(Vector2i(x, bottom_row)) != -1:
			columns.append(x)
	return columns

func start_level() -> void:
	enemy_spawner.on_game_reset()

func on_level_advance() -> void:
	advancer_crossed.emit()

func on_game_over() -> void:
	enemy_spawner.on_game_over()
	advancer.deactivate()
	entrances_exits.deactivate()

func on_level_finished() -> void:
	advancer.activate()
	entrances_exits.activate()
