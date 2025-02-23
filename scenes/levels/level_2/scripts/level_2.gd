extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition = get_node("GUI/NextLevelTransition")
	transition.color.a = 255
	Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.5


func _process(delta: float) -> void:
	# Check if player is on the ground after gravity pad.
	if Globals.player.is_on_floor() and not Globals.player.on_gravity_pad:
		Globals.player.gravity = Globals.player.BASE_GRAVITY * 0.5
