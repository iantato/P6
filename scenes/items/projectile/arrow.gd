extends Line2D

@export var max_scale: float = 2.0
@export var growth_speed: float = 1.0
@export var base_length: float = 1.0

var growth_time: float = 0.0
var player: Player 
func _ready() -> void:
  player = Globals.player
  scale = Vector2(base_length, 1)

func _process(delta: float) -> void:
  var mouse_pos = get_global_mouse_position()
  var direction = (mouse_pos - player.global_position).normalized()

  rotation = direction.angle()
  position = Globals.player.global_position + direction * 20

  if Input.is_action_pressed("use_item"):
    growth_time += delta * growth_speed
    scale.x  = clamp(base_length + growth_time, base_length, max_scale)
  else:
    growth_time = 0
    scale.x = base_length
    
