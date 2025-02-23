extends Grimoire
class_name FrictionGrimoire

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 500

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
  projectile.linear_velocity = direction * projectile_speed 

func clear(player: Player):
  pass
