extends Node2D

var speed_grimoire = preload("res://scenes/items/speed/speed_grimoire.tres")
var gravity_grimoire = preload("res://scenes/items/gravity/data/gravity_grimoire.tres")
var friction_grimoire = preload("res://scenes/items/friction/friction_grimoire.tres")

func _ready():
	Globals.player.inventory.items.append(speed_grimoire)
	Globals.player.inventory.items.append(gravity_grimoire)
	Globals.player.inventory.items.append(friction_grimoire)
