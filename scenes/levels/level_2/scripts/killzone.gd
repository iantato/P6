extends Area2D

func _on_killzone_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.reset_to_checkpoint()
		get_parent().get_node("Boulder").reset_to_checkpoint()
