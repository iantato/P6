extends Node2D

@export var rot := 30
@onready var grimoire = $Grimoire
func play_sequence():
  grimoire.play("open")
  await grimoire.animation_finished
  grimoire.play("idle")
  await grimoire.animation_finished
  grimoire.play("close")
  await grimoire.animation_finished

func flip(direction):
  grimoire.flip_h = direction < 0
  grimoire.rotation_degrees = (rot * (-1)) if direction == -1 else rot
