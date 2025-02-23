extends RigidBody2D
class_name FrictionProjectile

@export var spread_radius: int = 1

enum FrictionMaterial{
	TAR,
	HONEY,
	ICE,
	OIL
}

var TAR_ATLAS = [Vector2i(0, 1), Vector2i(2, 0), Vector2i(3, 0)]
var HONEY_ATLAS = [Vector2i(0, 1), Vector2i(2, 0), Vector2i(3, 0)]
var ICE_ATLAS = [Vector2i(0, 1), Vector2i(2, 0), Vector2i(3, 0)]
var OIL_ATLAS = [Vector2i(0, 1), Vector2i(2, 0), Vector2i(3, 0)]

var MaterialAtlas = {
	FrictionMaterial.TAR: {"source_id": 7, "atlas_coords": TAR_ATLAS},
	FrictionMaterial.HONEY: {"source_id": 4, "atlas_coords": HONEY_ATLAS},
	FrictionMaterial.ICE: {"source_id": 5, "atlas_coords": ICE_ATLAS},
	FrictionMaterial.OIL: {"source_id": 6, "atlas_coords": OIL_ATLAS}
}

var material_type: FrictionMaterial
var material_info 
var tilemap: TileMapLayer
	
func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer and body.name == "Friction":
		tilemap = body
		material_info = MaterialAtlas.get(material_type)
		print(tilemap)
		spread_tiles(global_position)
		queue_free()
		
func spread_tiles(center_pos: Vector2):
	if not tilemap:
		return
	
	var center_tile_pos = tilemap.local_to_map(tilemap.to_local(center_pos))

	# Loop symmetrically around the center tile
	for x in range(-spread_radius, spread_radius + 1):
		var pos = center_tile_pos + Vector2i(x, 1)
		change_cell(pos, x + 1)  # Change the center and all spread positions

func change_cell(pos: Vector2i, x: int):
	# Get the current tile's source ID
	var current_source_id = tilemap.get_cell_source_id(pos)
	var current_atlas_coords = tilemap.get_cell_atlas_coords(pos)


	# Check if the tile is different from the target material before changing
	var target_source_id = material_info.get("source_id")
	var target_atlas_coords = material_info.get("atlas_coords")
	var full_blocks = tilemap.get_used_cells_by_id(target_source_id, target_atlas_coords[1])

	if tilemap.get_cell_source_id(pos) != -1 and pos not in full_blocks:
		tilemap.set_cell(pos, target_source_id, target_atlas_coords[x])
	
