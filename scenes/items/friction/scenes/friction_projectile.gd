extends RigidBody2D

@export var spread_radius: int = 2

func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body is TileMapLayer and body.name == "Friction":
		print("YAY")
