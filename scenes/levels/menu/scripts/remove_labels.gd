extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var label = get_parent().get_node("GUI")
		label.visible = false
