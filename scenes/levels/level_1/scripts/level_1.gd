extends Node2D

var speed_grimoire = preload("res://scenes/items/speed/speed_grimoire.tres")

func _ready():
	var transition = get_node("GUI/NextLevelTransition")
	transition.from_prev_level()
	
	Globals.player.inventory.items.append(speed_grimoire)
