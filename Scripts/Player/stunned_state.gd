class_name StunnedState
extends State

@export var stun_time : float
var finished : float


func enter() -> void:
	entity_owner.animation_player.play("stunned")
	motor.reset_velocity()
	finished = Time.get_ticks_msec() / 1000 + stun_time

func update(delta : float) -> void:
	if Time.get_ticks_msec() / 1000 > finished:
		transitioned.emit("idle")
