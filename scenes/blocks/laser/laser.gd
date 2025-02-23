extends Node2D
enum LaserColor {
	RED,
	GREEN
}

var laser_atlas = {
	LaserColor.RED: Vector2(1, 4),
	LaserColor.GREEN: Vector2(0, 4)
}
@export var off_time: float = 1
@export var on_time: float = 1
@export var direction := Vector2i.DOWN
@export var color: LaserColor

var tilemap: TileMapLayer
var lasermap: TileMapLayer
var start_tile: Vector2i
var atlas_id = 8
var is_on: bool
var cells_to_change: Array

@onready var killzone = $KillZone 
@onready var on_timer = $OnTimer
@onready var off_timer = $OffTimer


func _ready():
	tilemap = get_parent().get_parent().get_node("Ground")
	lasermap = get_parent().get_parent().get_node("Laser")
	start_tile = tilemap.local_to_map(tilemap.to_local(global_position)) + direction
	lasermap.set_cell(start_tile, atlas_id, laser_atlas.get(color))
	cells_to_change = detect_collision(start_tile)
	initialize_killzone(start_tile, cells_to_change)
	on_timer.wait_time = on_time
	off_timer.wait_time = off_time
	off_timer.start()

func detect_collision(start_pos):
	var tiles_to_change = []
	var pos = start_pos

	while true:
		var tile_id = tilemap.get_cell_source_id(pos)  
		if tile_id != -1:  
			break
		tiles_to_change.append(pos)
		pos.y += 1  
	return tiles_to_change 
		
func shoot(blocks_to_change: Array):
	for tile in blocks_to_change:
		lasermap.set_cell(tile, atlas_id, laser_atlas.get(color)) 
	lasermap.set_cell(blocks_to_change[-1] + direction, atlas_id, laser_atlas.get(color) + Vector2(0, 1))
	
func unshoot(blocks_to_change: Array):
	for tile in blocks_to_change:
		lasermap.erase_cell(tile)  
	lasermap.erase_cell(blocks_to_change[-1] + direction)
	
func initialize_killzone(start_tile: Vector2i, cells: Array):
	killzone.global_position = tilemap.map_to_local(start_tile) + Vector2(0, (cells.size() / 2) * 16)
	killzone.resize(cells.size() * 24)


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("respawnable") and killzone.visible:
		body.reset_to_checkpoint()


func _on_timer_timeout() -> void:
	shoot(cells_to_change)
	killzone.visible = true
	off_timer.start()
func _on_off_timer_timeout() -> void:
	unshoot(cells_to_change)
	killzone.visible = false
	on_timer.start()
