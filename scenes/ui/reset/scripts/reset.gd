extends Button

func _on_button_pressed() -> void:
	print("test")
	get_parent().get_parent().get_node("Player").reset_to_checkpoint()
