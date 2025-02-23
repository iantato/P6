extends Node2D

@export var x_offset: int
@export var y_offset: int
@export var duration: float = 2.0  # Time to move between points
@export var wait_time: float = 0.5 # Pause at each end

var tween: Tween
var moving_to_end = true
var is_moving = true
var start_position: Vector2
var end_position: Vector2

func _ready():
	start_position = global_position
	end_position = start_position + Vector2(x_offset * 16, y_offset * 16)
	start_moving()

func start_moving():
	if not is_moving:
		return  # Don't start if stopped

	tween = create_tween()
	tween.tween_property(self, "global_position", end_position if moving_to_end else start_position, duration).set_trans(Tween.TRANS_SINE)
    
	await tween.finished
	await get_tree().create_timer(wait_time).timeout

	if is_moving:
		moving_to_end = !moving_to_end
		start_moving()

func stop_moving():
	is_moving = false
	if tween:
		tween.kill()  # Stop movement instantly

func resume_moving():
	if not is_moving:
		is_moving = true
		start_moving()
