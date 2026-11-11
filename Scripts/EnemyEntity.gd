class_name EnemyEntity
extends Entity
@onready var ground_checker: GroundChecker = %GroundChecker


func setup() -> void:
	ground_checker.setup(self)
	super.setup()

	
func on_health_depleted() -> void:
	queue_free()
