extends Control

@onready var pouches = [$Pouch1, $Pouch2, $Pouch3]
var selected = 0
func _ready() -> void:
  Globals.inventory_item_selected.connect(equip_item)
  Globals.hotbar_selected_slot_changed.connect(select_slot)
  pouches[selected].select()

func equip_item(grimoire: Grimoire, slot: int):
  pouches[slot].equip(grimoire)

func select_slot(slot: int):
  pouches[selected].select()
  pouches[slot].select()
  selected = slot
