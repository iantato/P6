extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition = get_node("GUI/NextLevelTransition")
	transition.reset_all(Globals.current_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
