extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
