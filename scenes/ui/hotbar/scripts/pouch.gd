extends Control

@onready var grimoire = $Grimoire
@onready var overlay = $Overlay

@export var pouch_no: int
func _ready() -> void:
  self.visible = false
  overlay.visible = false

func equip(item: Grimoire):
  grimoire.texture = item.hotbar_icon 
  self.visible = true

func unequip():
  self.visible = false

func select():
  if overlay.visible:
    overlay.visible = false
  else:
    overlay.visible = true
    
