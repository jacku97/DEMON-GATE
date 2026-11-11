class_name SpawnOnHit
extends OnHitBehaviour

@export var to_spawn : PackedScene

func perform(context : Dictionary) -> void:
	var o := to_spawn.instantiate()
	o.global_position = context["point"]
	get_tree().current_scene.add_child(o)
