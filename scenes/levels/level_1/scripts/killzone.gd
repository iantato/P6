extends Node

func _on_killzone_entered(body: Player) -> void:
	body.reset_to_checkpoint()
