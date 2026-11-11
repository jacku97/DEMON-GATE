class_name ProjectileSlot
extends Resource

var current_projectile : ProjectileData = null

func set_projectile(new_p : ProjectileData) -> void:
	current_projectile = new_p

func clear_projectile() -> void:
	current_projectile = null

func get_projectile_name() -> String:
	if current_projectile == null : return ""
	return current_projectile.display_name
	
func get_projectile_sprite() -> Texture2D:
	if current_projectile == null : return null
	return current_projectile.sprite

func get_projectile() -> ProjectileBase:
	if current_projectile == null : return null
	return current_projectile.scene.instantiate() as ProjectileBase
