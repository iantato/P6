extends Node

var speed_grimoire = preload("res://scenes/items/speed/speed_grimoire.tres")
var gravity_grimoire = preload("res://scenes/items/gravity/data/gravity_grimoire.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition = get_node("GUI/NextLevelTransition")
	transition.from_prev_level()
	
	Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.5
	
	Globals.player.inventory.items.append(speed_grimoire)
	Globals.player.inventory.items.append(gravity_grimoire)


func _process(delta: float) -> void:
	# Check if player is on the ground after gravity pad.
	if Globals.player.is_on_floor() and not Globals.player.on_gravity_pad:
		Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.5
