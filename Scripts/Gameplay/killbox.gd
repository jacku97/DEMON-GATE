class_name Killbox
extends Node2D

var enabled : bool = false

func set_enable(state : bool) -> void:
	print_debug("kill box setting enabled " + str(state))
	enabled = state
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print_debug("Kill box entered")
	if body is Entity and enabled:
		print_debug("Kill box enabled, body is entity")
		if body.active:
			print_debug("body active")
			body.on_health_depleted()
