extends Grimoire

@export var speed_per_delta = 50
@export var max_speed = 180

func use(player: Player, delta: float):
	clear(player)
	player.current_speed += min((speed_per_delta * delta), max_speed)
	

func clear(player: Player):
	player.current_speed = player.BASE_SPEED
