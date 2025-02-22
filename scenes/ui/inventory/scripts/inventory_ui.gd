extends Control

@onready var green_selected = $GreenSelected
@onready var red_selected = $RedSelected
@onready var selected = red_selected

var locked_items: Dictionary
var is_open: bool

func open_inventory(items: Array[Grimoire], unlocked: bool) -> void:
    if !is_open:
        for item in items:
            if locked_items.has(item.type):
                locked_items.get(item.type).unlock(item)
                if unlocked:
                    locked_items.get(item.type).enable()
        self.visible = true
        is_open = true
    else:
        self.visible = false
        is_open = false

func populate_items():
    for item in red_selected.get_children():
        locked_items[item.type] = item

    for item in green_selected.get_children():
        locked_items[item.type] = item

func unequip_grimoire(grimoire: Grimoire):
    locked_items.get(grimoire.type).unequip()

func _ready() -> void:
    populate_items()
    green_selected.visible = false
    self.visible = false
    Globals.hotbar_item_replaced.connect(unequip_grimoire)

func _on_red_button_pressed() -> void:
    selected.visible = false
    red_selected.visible = true
    selected = red_selected

func _on_green_button_pressed() -> void:
    selected.visible = false
    green_selected.visible = true
    selected = green_selected

func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("inventory"):
        open_inventory(Globals.player.inventory.items, true)
