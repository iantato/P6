extends Node

func _on_killzone_entered(body: Node2D) -> void:
	if body == Player:
		body.reset_to_checkpoint()
