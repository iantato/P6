extends Area2D

var tilemap: TileMapLayer
var particle: CPUParticles2D
var poof_sound: AudioStreamPlayer2D
@export var delay: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tilemap = get_parent()
	particle = get_node("Explosion")
	poof_sound = particle.get_node("Poof")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _explode_bridge(body: Node2D) -> void:
	var tile_pos = tilemap.local_to_map(body.global_position)
	var world_pos = tilemap.map_to_local(tile_pos)
	world_pos.y -= 5
	var cell_id = tilemap.get_cell_source_id(tile_pos)
	
	while (cell_id == 3):
		tilemap.set_cell(tile_pos, cell_id)
		
		if particle:
			particle.global_position = world_pos
			particle.emitting = true
		
		if poof_sound:
			poof_sound.play()
			
		tile_pos.x += 1
		
		await get_tree().create_timer(delay).timeout
		world_pos = tilemap.map_to_local(tile_pos)
		cell_id = tilemap.get_cell_source_id(tile_pos)
		world_pos.y -= 5
