extends Area2D

signal timer_finished

var activated: bool = false
var bodies: Dictionary

func activate(strength: float):
	if !activated:
		activated = true
		$Timer.start()


func _on_timer_timeout() -> void:
	emit_signal("timer_finished")
	reset_effects()
	activated = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("punchable"):
		print(body)
		bodies[body] = {"gravity": body.gravity_scale, "linear": body.linear_damp, "angular": angular_damp}
		body.gravity_scale = -0.02
		body.linear_damp = 0.02
		body.angular_damp = 0.02
		
func reset_effects():
	for body in bodies.keys():
		body.gravity_scale = bodies.get(body).get("gravity")
		body.linear_damp = bodies.get(body).get("linear")
		body.angular_damp = bodies.get(body).get("angular")
