extends Control

var selected

signal key_pressed

func _ready() -> void:
  self.visible = false

func open() -> int: 
  self.visible = true
  await key_pressed
  self.visible = false
  return selected

func _on_slot_1_pressed() -> void:
  selected = 0
  emit_signal("key_pressed")

func _on_slot_2_pressed() -> void:
  selected = 1
  emit_signal("key_pressed")

func _on_slot_3_pressed() -> void:
  selected = 2
  emit_signal("key_pressed")
