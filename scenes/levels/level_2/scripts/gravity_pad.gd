extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gravity_pad(body: Node2D) -> void:
	if body.name == "Player":
		Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.2
		Globals.player.on_gravity_pad = true


func _exited_gravity_pad(body: Node2D) -> void:
	if body.name == "Player":
		Globals.player.on_gravity_pad = false
