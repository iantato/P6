extends Control

@onready var pouches = [$Pouch1, $Pouch2, $Pouch3]
var selected = 0
func _ready() -> void:
	Globals.inventory_item_selected.connect(equip_item)
	Globals.hotbar_selected_slot_changed.connect(select_slot)
	Globals.hotbar_item_slot_replaced.connect(change_item)
	pouches[selected].select()

func equip_item(grimoire: Grimoire, slot: int):
	pouches[slot].equip(grimoire)
	
func change_item(grimoire: Grimoire, slot: int):
	if grimoire == null:
		pouches[slot].unequip()
		return
	pouches[slot].equip(grimoire)

func select_slot(slot: int):
	pouches[selected].select()
	pouches[slot].select()
	selected = slot
