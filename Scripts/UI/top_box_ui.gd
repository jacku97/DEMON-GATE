class_name TopBoxUI
extends PanelContainer

@onready var weapon_1_image: TextureRect = %Weapon1Image
@onready var weapon_2_image: TextureRect = %Weapon2Image


func update_weapons(weapon_1 : Texture2D, weapon_2 : Texture2D) -> void:
	print_debug("Updating weapon sprites")
	weapon_1_image.texture = weapon_1
	weapon_2_image.texture = weapon_2
