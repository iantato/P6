extends TileMapLayer

@export var time_before_closing: int

func _ready():
	var button = get_parent().get_node("Button")
	$Timer.wait_time = time_before_closing
	button.button_activated.connect(open_door)
	button.button_deactivated.connect(close_door)
	
func open_door():
	collision_enabled = false
	visible = false
	
func close_door():
	$Timer.start()

func _on_timer_timeout() -> void:
	collision_enabled = true
	visible = true
