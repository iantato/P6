# Globals.gd
extends Node

signal inventory_item_selected(grimoire: Grimoire, slot: int)
signal hotbar_item_slot_replaced(grimoire: Grimoire, slot: int)
signal hotbar_item_replaced(grimoire: Grimoire)
signal hotbar_selected_slot_changed(slot: int)
# Player instance
var player: Node = null
var player_id: int = 0
var current_level: int = 1

# Time tracking variables
var level_times: Dictionary = {}  # Stores time spent in each level
var current_level_start_time: int = 0  # Tracks the start time of the current level

func relay_item_selected(grimoire: Grimoire, slot: int):
	emit_signal("inventory_item_selected", grimoire, slot)

func relay_hotbar_item_replaced(grimoire: Grimoire):
	emit_signal("hotbar_item_replaced", grimoire)

func relay_changed_selected_slot(slot: int):
	emit_signal("hotbar_selected_slot_changed", slot)

func relay_item_slot_replaced(grimoire: Grimoire, slot: int):
	emit_signal("hotbar_item_slot_replaced", grimoire, slot)
