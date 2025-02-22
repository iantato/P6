extends Grimoire
class_name GravityGrimoire

@export var gravity_multiplier: float = 20
@export var gravity_area: PackedScene

var gravity_area_scene
var can_cast: bool = true
var direction: int = 1

func use(player: Player, delta: float):
	if can_cast:
		var gravity = min((gravity_multiplier * delta) * direction, 1200) if direction == 1 else max((gravity_multiplier * delta) * direction, -900)
		if !gravity_area_scene:
			gravity_area_scene = gravity_area.instantiate()
			player.add_child(gravity_area_scene)
		gravity_area_scene.activate(gravity)
		toggle_cast()
		await gravity_area_scene.timer_finished
		toggle_cast()
		timer_finished(player)

		

func clear(player: Player):
	player.gravity = player.BASE_GRAVITY
 
func switch_direction():
	direction *= -1
	
func timer_finished(player):
	if gravity_area_scene:
		player.remove_child(gravity_area_scene)
		gravity_area_scene = null
  
func toggle_cast():
	can_cast = false if can_cast else true
