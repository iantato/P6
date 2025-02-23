extends Area2D

func _next_level_entered(body: Node2D) -> void:
	if body.name == "Player":
		Globals.player.toggle_movement()
		Globals.current_level += 1
		var transition = get_parent().get_node("GUI/NextLevelTransition")
		await transition.to_next_level(Globals.current_level)
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file(transition.scenes[Globals.current_level])
