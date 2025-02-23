extends Grimoire
class_name FrictionGrimoire

@export var projectile_scene: PackedScene
@export var arrow_scene: PackedScene
@export var projectile_speed: float = 500
@export var material: FrictionProjectile.FrictionMaterial

var materials = [
	FrictionProjectile.FrictionMaterial.TAR,
	FrictionProjectile.FrictionMaterial.HONEY,
	FrictionProjectile.FrictionMaterial.ICE,
	FrictionProjectile.FrictionMaterial.OIL
]

var current_slot = 0
var max_slot = materials.size()

var arrow

func use(player: Player, delta: float):
	if not arrow_scene:
		return
		
	if not projectile_scene:
		return

	if not player:
		return
	var projectile = projectile_scene.instantiate() as RigidBody2D
	projectile.material_type = materials[current_slot]
	player.get_parent().add_child(projectile)
 
	var origin_position = player.global_position

	var mouse_position = player.get_global_mouse_position()
	var direction = (mouse_position - origin_position).normalized()

	projectile.global_position = origin_position + direction * 20

	var charged_projectile_speed = projectile_speed * delta

	projectile.linear_velocity = direction * charged_projectile_speed

func clear(player: Player):
	if arrow:
		player.get_parent().remove_child(arrow)

func toggle():
	if current_slot < max_slot:
		current_slot += 1
	else:
		current_slot = 0
		
func activate(player: Player):
	if !arrow:
		arrow = arrow_scene.instantiate()
	player.get_parent().add_child(arrow)
