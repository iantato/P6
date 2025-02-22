extends Control
class_name BaseGrimoire

@onready var locked = $Locked
@onready var unlocked = $Unlocked
@onready var closed = $ClosedBook
@onready var selector = get_parent().get_parent().get_node("Selector")

@export var type: Grimoire.Types

var is_unlocked: bool = false
var grimoire: Grimoire

signal item_selected(grimoire: Grimoire, slot: int)

func _ready() -> void:
  item_selected.connect(Globals.relay_item_selected)
  self.disabled = true
  unlocked.visible = false
  closed.visible = false

func unlock(item: Grimoire):
  self.disabled = true
  if !is_unlocked:
    grimoire = item
    is_unlocked = true
    locked.visible = false
    closed.visible = true

func enable():
  self.disabled = false

func equip(slot: int):
  if closed.visible == true:
    closed.visible = false
    unlocked.visible = true

func unequip():
  if closed.visible == false:
    closed.visible = true
    unlocked.visible = false

func _on_pressed() -> void:
  var slot = await selector.open()
  emit_signal("item_selected", grimoire, slot)
  equip(slot)
