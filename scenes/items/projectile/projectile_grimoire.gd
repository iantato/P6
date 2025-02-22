extends Grimoire
class_name ProjectileGrimoire

@export var projectile_scene: PackedScene
@export var arrow_scene: PackedScene
@export var projectile_speed: float = 500

var arrow

func use(player: Player, delta: float):
	if not projectile_scene:
		return

	if not player:
		return  # Prevent errors if it's not parented

	var projectile = projectile_scene.instantiate() as RigidBody2D
	player.get_parent().add_child(projectile)  # Add to the main scene
  # Use player's position since Grimoire has no global_position
	var origin_position = player.global_position

  # Get direction from Player to the mouse
	var mouse_position = player.get_global_mouse_position()
	var direction = (mouse_position - origin_position).normalized()

	projectile.global_position = origin_position + direction * 20
  # Apply velocity to projectile
	var charged_projectile_speed = projectile_speed * delta
	print(projectile_speed)
	projectile.linear_velocity = direction * charged_projectile_speed

func clear(player: Player):
	if arrow:
		player.get_parent().remove_child(arrow)

func activate(player: Player):
	if !arrow:
		print("TEST")
		arrow = arrow_scene.instantiate()
	player.get_parent().add_child(arrow)
