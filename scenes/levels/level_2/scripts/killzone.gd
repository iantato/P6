extends Area2D

func _on_killzone_entered(body: Node2D) -> void:
	if body.name == "Player":
		print('test')
		body.reset_to_checkpoint()
