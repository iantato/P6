extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.has_focus():
		accept_event()

func _submit(text) -> void:
	Sql.insert_player(text)
	get_tree().change_scene_to_file("res://scenes/levels/menu/menu.tscn")
