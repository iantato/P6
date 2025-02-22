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

@export var item_name: String
@export var use_type: UseType
@export var type: Types
@export var toggleable: bool
@export var hotbar_icon: Texture
@export var scene: PackedScene
