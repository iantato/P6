extends Camera2D

@export var y_threshold: float = 50

@export var default_offset: Vector2 = Vector2(0, -80)
@export var default_zoom: Vector2 = Vector2(0.8, 0.8)
@export var transition_speed: float = 4.0

func _process(delta):
	var target_offset = default_offset
	var target_zoom = default_zoom
	
	if Globals.player.global_position.y < y_threshold:
		target_offset = Vector2(0, 80)
		target_zoom = Vector2(0.4, 0.4)
	
	offset = offset.lerp(target_offset, transition_speed * delta)
	zoom = zoom.lerp(target_zoom, transition_speed * delta)
