extends StaticBody2D

@onready var label: Label = $Label
var player_inside: bool = false
var player = null

func _ready() -> void:
	label.visible = false

func _process(delta):
	if player_inside:
		if Input.is_action_just_pressed("interact"):
			player.inventory_ui.open_inventory(player.inventory.items, true)
			player.toggle_movement()

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.name == "Player":
		label.visible = true
		player = body
		player_inside = true

func _on_area_2d_body_exited(body:Node2D) -> void:
	if body.name == "Player":
		label.visible = false
		player_inside = false
		player = null
