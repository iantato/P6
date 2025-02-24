extends Button

func _on_button_pressed() -> void:
	get_parent().get_parent().get_tree().reload_current_scene()
