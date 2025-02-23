extends Node2D
enum LaserColor {
	RED,
	GREEN
}

var laser_atlas = {
	LaserColor.RED: Vector2(1, 4),
	LaserColor.GREEN: Vector2(0, 4)
}
@export var interval: float
@export var direction := Vector2i.DOWN
@export var color: LaserColor

var tilemap: TileMapLayer
var lasermap: TileMapLayer
var start_tile: Vector2i

@onready var killzone = $KillZone 


func _ready():
	tilemap = get_parent().get_parent().get_node("Ground")
	lasermap = get_parent().get_parent().get_node("Laser")
	start_tile = tilemap.local_to_map(tilemap.to_local(global_position)) + direction
	lasermap.set_cell(start_tile, 7, laser_atlas.get(color))
	var cells_to_change = detect_collision(start_tile)
	initialize_killzone(start_tile, cells_to_change)
	shoot(cells_to_change)

func detect_collision(start_pos):
	var tiles_to_change = []
	var pos = start_pos

	while true:
		pos.y += 1  
		var tile_id = tilemap.get_cell_source_id(pos)  

		if tile_id == -1:  
			tiles_to_change.append(pos)
		else:
			break
	return tiles_to_change 
		
func shoot(blocks_to_change: Array):
	for tile in blocks_to_change:
		print(tile)
		lasermap.set_cell(tile, 7, laser_atlas.get(color))  # Add laser tile
	lasermap.set_cell(blocks_to_change[-1] + Vector2i(0, 1), 7, laser_atlas.get(color) + Vector2(0, 1))
	
func initialize_killzone(start_tile: Vector2i, cells: Array):
	killzone.global_position = tilemap.map_to_local(start_tile) + Vector2(0, (cells.size() / 2) * 16)
	killzone.resize(cells.size() * 24)
