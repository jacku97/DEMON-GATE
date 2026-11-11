class_name GameOverPanel
extends PanelContainer

var active : bool = false
signal accept

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and active == true:
		accept.emit()
		active = false
		hide()

func show_panel() -> void:
	active = true
	show()
