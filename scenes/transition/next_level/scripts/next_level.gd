extends Node

var texts : Dictionary = {
	0: "Speed is calculated as the distance traveled divided by the time taken (Speed = Distance / Time), and it tells you how fast an object is moving.",
	1: "Gravity is the force that pulls objects toward each other, like how Earth pulls you to the ground, and its strength is calculated using F = m ⋅ g, where m is mass and g is the acceleration due to gravity (about 9.8 m/s^2 on Earth).",
	2: "Friction is the force that slows things down when they rub against each other, and it depends on how rough the surfaces are and how hard they’re pressed together."
}

func to_next_level(current_level: int = Globals.current_level):
	var label: Label = get_node("Label")
	label.text = texts[current_level]
	
	var animation: AnimationPlayer = get_node("AnimationPlayer")
	animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
