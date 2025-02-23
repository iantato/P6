extends Node2D

signal button_activated
signal button_deactivated

func _ready():
	$ButtonBody/ButtonSprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body and body.name != $ButtonBody.name and body is not TileMapLayer:
		$ButtonBody/ButtonSprite.play("press_down")
		emit_signal("button_activated")


func _on_button_area_body_exited(body: Node2D) -> void:
	$ButtonBody/ButtonSprite.play("press_up")
	emit_signal("button_deactivated")
