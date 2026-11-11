class_name Main
extends Node2D

@export var player_scene : PackedScene
@export var starting_level_scene : PackedScene
var player : Entity = null
@onready var player_spawn: Node2D = %PlayerSpawn
@onready var enemy_spawner: EnemySpawner = %EnemySpawner
@onready var hearts_container: HeartsContainer = %HeartsContainer
@onready var top_box_ui: TopBoxUI = %TopBoxUI
@onready var game_over_panel: GameOverPanel = %GameOverPanel

var current_level : LevelController

signal game_reset
signal game_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	start_game()

func start_game() -> void:
	if current_level != null:
		current_level.queue_free()
	current_level = load_level(starting_level_scene)
	if player == null:
		var p : Entity = player_scene.instantiate()
		add_child(p)
		player = p
	player.global_position = current_level.get_spawn_point()
	for child in player.get_children():
		if child is WeaponsHandler:
			print_debug("Found weapon handler")
			child.weapons_updated.connect(top_box_ui.update_weapons)
			break
	player.setup()
	if !player.dead.is_connected(on_game_over):
		player.dead.connect(on_game_over)
	if !player.health.health_updated.is_connected(hearts_container.update_health):
		player.health.health_updated.connect(hearts_container.update_health)
	if game_over_panel.accept.is_connected(start_game):
		game_over_panel.accept.disconnect(start_game)


	game_reset.emit()
	current_level.start_level()
	game_over_panel.hide()

func load_level(new_level : PackedScene) -> LevelController:
	var l : LevelController = new_level.instantiate()
	get_tree().current_scene.add_child(l)
	return l

func test():
	print_debug("asd")


func on_game_over() -> void:
	player.active = false
	game_over_panel.show_panel()
	game_over_panel.accept.connect(start_game)
	game_over.emit()
	current_level.on_game_over()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()
