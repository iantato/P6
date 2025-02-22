extends Resource 
class_name Grimoire

enum UseType {
  PRESS,
  HOLD
}

enum Types {
  SPEED,
  FRICTION,
  GRAVITY,
  PROJECTILE,
  INERTIA,
  THRUST
}

@export var item_name: String = "Default Grimoire Name"
@export var use_type: UseType
@export var type: Types
@export var toggleable: bool = false
@export var activate_on_equip: bool = false
@export var hotbar_icon: Texture
@export var scene: PackedScene
