extends Button

signal _on_Button_pressed

func _on_Button_pressed() -> void:
	emit_signal("_on_Button_pressed")
