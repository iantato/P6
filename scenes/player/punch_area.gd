extends Area2D

var punch_strength: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  self.monitoring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  handle_input()

func handle_input():
  if Input.is_action_just_pressed("punch"):
    get_parent().toggle_movement()
  elif Input.is_action_just_released("punch"):
    perform_punch()
    get_parent().toggle_movement()
  elif Input.is_action_pressed("punch"):
    print(punch_strength)
    punch_strength += 5


# Punch mechanic
var can_punch = true

func perform_punch():
  can_punch = false
  self.monitoring = true

  await get_tree().create_timer(0.1).timeout
  self.monitoring = false
  punch_strength = 0


func _on_body_entered(body: Node2D) -> void:
  if body.is_in_group("punchable"):
    if body is RigidBody2D:
      # Assuming Player has a 'sprite_direction' boolean
      var direction = Vector2.RIGHT if get_parent().sprite_direction else Vector2.LEFT
      body.apply_impulse(direction * min(punch_strength, 500))  # Removed unnecessary * -1
  elif body.is_in_group("wardrobe"):
    body.open_chest(get_parent().get_items())
