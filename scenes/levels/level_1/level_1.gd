extends Node2D

var speed_grimoire = preload("res://scenes/items/speed/speed_grimoire.tres")
func _ready():
	Globals.player.inventory.items.append(speed_grimoire)
