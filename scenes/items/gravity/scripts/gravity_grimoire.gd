extends Grimoire

@export var gravity_multiplier: float = 20

var direction: int = 1

func use(player: Player, delta: float):
  clear(player)
  player.gravity += min((gravity_multiplier * delta) * direction, 1200) if direction == 1 else max((gravity_multiplier * delta) * direction, -900)
  print(player.gravity)

func clear(player: Player):
  player.gravity = player.BASE_GRAVITY
 
func switch_direction():
  direction *= -1
  
