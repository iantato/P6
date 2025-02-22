extends Node2D

@export var move_time: float = 2.0
@export var point_a: Vector2
@export var point_b: Vector2
@export var auto_start: bool = true
@export var pause_on_stop: bool = false

var moving_to_b = true
var tween: Tween

func _ready() -> void:
    if auto_start:
        move_to(point_b)

func move_to(target: Vector2):
    if tween:
        tween.kill()
    tween = create_tween()
    tween.tween_property(self, "position", target, move_time).set_trans(Tween.TRANS_SINE)
    await tween.finished
    if !pause_on_stop:
        moving_to_b = !moving_to_b
        move_to(point_a if moving_to_b else point_b)

func stop_movement():
    if tween:
        tween.kill()  # Stops movement

func start_movement():
    move_to(point_b if moving_to_b else point_a)
