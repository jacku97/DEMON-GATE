class_name LaunchEnemyState
extends State


func enter() -> void:
	var dir = randi_range(-1,1)
	while dir == 0:
		dir = randi_range(-1,1)
	motor.hard_set_direction(dir)
	motor.launch()
