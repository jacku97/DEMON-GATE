class_name ShootState
extends State

@export var shoot_time : float = 0.5
var finished : float
var slot : int
var shot_active : bool = false
func enter() -> void:
	motor.reset_velocity()
	shot_active = false


func update(delta : float) -> void:
	
	if Input.is_action_just_released("shoot_1") and !shot_active:
		if weapons.projectile_1.current_projectile == null:
			transitioned.emit("idle")
			return
		slot = 1
		start_shot()
			
	if Input.is_action_just_released("shoot_2") and !shot_active:
		if weapons.projectile_2.current_projectile == null:
			transitioned.emit("idle")
			return
		slot = 2
		start_shot()

func start_shot() -> void:
	shot_active = true
	entity_owner.animation_player.play("shootcharge")
	entity_owner.animation_player.animation_finished.connect(animation_finished)
	

func animation_finished(anim_name : String) -> void:
	if anim_name == "shootcharge" :
		entity_owner.animation_player.play("shoot")
		weapons.shoot_projectile(slot)
	if anim_name == "shoot":
		entity_owner.animation_player.animation_finished.disconnect(animation_finished)
		transitioned.emit("idle")
		return



func exit() -> void:
		pass
