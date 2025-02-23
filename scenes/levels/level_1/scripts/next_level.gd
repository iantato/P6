extends Area2D

func _next_level_entered(body: Node2D) -> void:
	if body.name == "Player":
		var transition = get_parent().get_node("GUI/NextLevelTransition")
		transition.to_next_level(2)
		#get_tree().change_scene_to_file("res://scenes/levels/level_2/level_2.tscn")
