class_name WeaponsHandler
extends Node2D

@export var starting_projectile : ProjectileData
@export var projectile_pool_size : int = 100

var projectile_1 : ProjectileSlot
var projectile_2 : ProjectileSlot
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var current_projectile : String
var projectile_pool : Array[Projectile]

var entity_owner : Entity

signal weapons_updated(wep_1 : Texture2D, wep_2 : Texture2D)
signal finished_shot

func setup() -> void:
	entity_owner = owner
	projectile_1 = ProjectileSlot.new()
	projectile_2 = ProjectileSlot.new()
	set_projectile(starting_projectile, 1)


func set_projectile(new_projectile : ProjectileData, slot : int) -> void:
	match slot:
		1:
			print_debug("Setting projectile 1")
			projectile_1.set_projectile(new_projectile)
		2:
			print_debug("Setting projectile 1")
			projectile_2.set_projectile(new_projectile)
	weapons_updated.emit(projectile_1.get_projectile_sprite(), projectile_2.get_projectile_sprite())

func start_shot() -> void:
	animation_player.play("shootcharge")

func shoot_projectile(slot : int) -> void:
	if slot > 2 : return
	if slot < 1 : return
	var p : ProjectileBase
	match slot:
		1:
			p = projectile_1.get_projectile()

		2:
			p = projectile_2.get_projectile()

	if p == null : return
	p.setup()
	p.launch(entity_owner.global_position + (Vector2(25,0) * entity_owner.facing_direction), entity_owner.facing_direction)
	get_tree().current_scene.add_child(p)
	entity_owner.dead.connect(p.die)

	
