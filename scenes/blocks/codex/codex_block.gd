extends StaticBody2D

@onready var label: Label = $Label
var player_inside: bool = false
var player = null

func _ready() -> void:
	$Button.visible = false
	$Button.stop()

func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		player.toggle_movement()

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		$Button.visible = true
		player = body
		player_inside = true
		$Button.play("default")
		player.inside = player_inside

func _on_area_2d_body_exited(body:Node2D) -> void:
	if body.name == "Player":
		$Button.visible = false
		$Button.stop()
		player_inside = false
		player.inside = player_inside
		player = null
