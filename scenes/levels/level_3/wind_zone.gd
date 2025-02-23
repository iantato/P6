extends Area2D

@export var change_every: float
@export var min_strength: float
@export var max_strength: float
@onready var timer = $Timer
var force: Vector2

func _ready():
	timer.wait_time = change_every
	timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.wind_force = force


func _on_timer_timeout() -> void:
	var random_wind_force = randf_range(min_strength, max_strength)
	force = Vector2(random_wind_force, 0)
	Globals.player.wind_force = force
