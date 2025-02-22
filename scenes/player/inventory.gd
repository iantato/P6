extends Node
class_name Inventory

@export var items: Array[Grimoire]

var player
func _input(event: InputEvent) -> void:
    player = Globals.player
    if Input.is_action_just_pressed("inventory"):
        player.inventory_ui.open_inventory(items, false)
  
func equip_item(item: Grimoire):
    var result: bool = player.hotbar.equip_item(item)
    if result:
        items.erase(item)
    else:
        print("Hotbar is full")
