extends CharacterBody2D
class_name Player

# Exported variables (adjustable in inspector)
@export var BASE_SPEED := 100.0
@export var JUMP_VELOCITY := -300.0
@export var acceleration := 800.0
@export var default_friction := 600.0  # Renamed from "friction" to "default_friction"

var checkpoint_position: Vector2 = Vector2.ZERO
var inside: bool

var BASE_GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
# Friction variables
var current_friction: float = default_friction  # Current friction value
var is_on_special_surface: bool = false  # Track if the player is on a special surface

const AREA_OFFSET_X := 10.0

var movement_enabled = true
var current_speed := BASE_SPEED
var gravity = BASE_GRAVITY
var on_gravity_pad : bool = false
var sprite_direction = 1

# Floating state variables
var is_floating: bool = false  # Track if the player is in floating mode
var float_amplitude: float = 500.0  # How far the player floats up and down
var float_speed: float = 2.0  # How fast the player floats
var float_time: float = 0.0  # Timer for floating animation
var tilemap: TileMapLayer

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Fixed reference
@onready var area: Area2D = $PlayerArea2D
@onready var inventory: Inventory = $Inventory


func _ready() -> void:
	if Globals.player != null:
		queue_free()  # Delete this duplicate instance if another already exists
		return
	checkpoint_position = global_position
	print(checkpoint_position)
	Globals.player = self
	tilemap = get_parent().get_node("Friction")
	add_child(inventory)


func _physics_process(delta: float) -> void:
	handle_normal_movement(delta)  # Handle normal movement

	if is_on_floor():
		current_friction = get_tile_friction()

	move_and_slide()

func handle_normal_movement(delta: float):
	# Apply gravity (either custom or default)
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump handling (only if on the floor)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	var target_velocity = direction * current_speed

	if direction != 0:
		velocity.x = move_toward(velocity.x, target_velocity, acceleration * delta)
		animated_sprite.flip_h = direction < 0  # Now works properly
		sprite_direction = direction > 0
		area.position.x = AREA_OFFSET_X * direction
		var grimoires = get_tree().get_nodes_in_group("grimoire")
		for grimoire in grimoires:
			grimoire.position.x = 0 if direction == 1 else -28
			grimoire.flip(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, current_friction * delta)

	# Update animation
	var new_animation = "idle"
	if velocity.x != 0 and is_on_floor():
		new_animation = "run"
	if velocity.y != 0 and not is_on_floor():
		new_animation = "jump"
	if Input.is_action_pressed("use_item") and $Hotbar.hotbar[$Hotbar.selected_slot]:
		toggle_movement()
		new_animation = "cast_1"

	if animated_sprite.animation != new_animation:
		animated_sprite.play(new_animation)

func get_tile_friction() -> float:
	if not tilemap:
		return default_friction

	var local_pos = tilemap.to_local(global_position)
	var player_pos = tilemap.local_to_map(local_pos)
	var tile_pos = player_pos + Vector2i(0, 1)
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	if tile_data:
		var friction = tile_data.get_custom_data("Friction")
		if friction > default_friction:
			current_speed = BASE_SPEED * (1.0/(1.0+(friction/100)))
			return friction
		if friction:
			current_speed = BASE_SPEED
			return friction

	current_speed = BASE_SPEED
	return default_friction
	
func reset_to_checkpoint():
	global_position = checkpoint_position
	velocity = Vector2.ZERO

func toggle_movement():
	movement_enabled = not movement_enabled
	if not movement_enabled:
		velocity.x = 0
		velocity.y = 0
