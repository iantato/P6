extends Node

var speed_grimoire = preload("res://scenes/items/speed/speed_grimoire.tres")
var gravity_grimoire = preload("res://scenes/items/gravity/data/gravity_grimoire.tres")
var friction_grimoire = preload("res://scenes/items/friction/friction_grimoire.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition = get_node("GUI/NextLevelTransition")
	transition.from_prev_level()
	
	Globals.player.inventory.items.append(speed_grimoire)
	Globals.player.inventory.items.append(gravity_grimoire)
	Globals.player.inventory.items.append(friction_grimoire)
