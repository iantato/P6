extends RigidBody2D
var default_friction = 0.1
var current_friction = default_friction
var tilemap: TileMapLayer
var original_pos: Vector2

func _ready():
	tilemap = get_parent().get_node("Friction")
	original_pos = global_position

func _physics_process(delta):
	current_friction = get_tile_friction()

	# Apply friction to gradually slow down velocity
	if linear_velocity.length() > 0.1:
		var friction_force = -linear_velocity.normalized() * current_friction * delta * 100
		apply_central_impulse(friction_force)

func get_tile_friction() -> float:
	if not tilemap:
		return default_friction

	var local_pos = tilemap.to_local(global_position)
	var tile_pos = tilemap.local_to_map(local_pos)
	var tile_data = tilemap.get_cell_tile_data(tile_pos)

	if tile_data:
		var friction = tile_data.get_custom_data("friction")
		return friction if friction else default_friction

	return default_friction

func reset_to_checkpoint():
	global_position = original_pos
	print(global_position)
	set_deferred("global_position", Vector2(0, 0))
