# Globals.gd
extends Node

signal inventory_item_selected(grimoire: Grimoire, slot: int)
signal hotbar_item_slot_replaced(grimoire: Grimoire, slot: int)
signal hotbar_item_replaced(grimoire: Grimoire)
signal hotbar_selected_slot_changed(slot: int)
# Player instance
var player: Node = null
var player_id: int = 0
var current_level: int = 2

var timers = {1: 0, 2: 0, 3: 0}
var bridge_tiles: Array = []

func relay_item_selected(grimoire: Grimoire, slot: int):
	emit_signal("inventory_item_selected", grimoire, slot)

func relay_hotbar_item_replaced(grimoire: Grimoire):
	emit_signal("hotbar_item_replaced", grimoire)

func relay_changed_selected_slot(slot: int):
	emit_signal("hotbar_selected_slot_changed", slot)

func relay_item_slot_replaced(grimoire: Grimoire, slot: int):
	emit_signal("hotbar_item_slot_replaced", grimoire, slot)
