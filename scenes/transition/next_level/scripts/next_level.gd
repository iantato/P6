extends Node

var texts : Dictionary = {
	0: "Speed is calculated as the distance traveled divided by the time taken (Speed = Distance / Time), and it tells you how fast an object is moving. (You have obtained Speed Grimoire)",
	1: "Gravity is the force that pulls objects toward each other, like how Earth pulls you to the ground, and its strength is calculated using F = m ⋅ g, where m is mass and g is the acceleration due to gravity (about 9.8 m/s^2 on Earth). (You have obtained Gravity Grimoire)",
	2: "Friction is the force that slows things down when they rub against each other, and it depends on how rough the surfaces are and how hard they’re pressed together. (You have obtained Friction Grimoire)",
	3: "To be continued in Physics 2"
}

var scenes : Dictionary = {
	0: "res://scenes/levels/level_1/level_1.tscn",
	1: "res://scenes/levels/level_2/level_2.tscn",
	2: "res://scenes/levels/level_3/level_3.tscn",
	3: "res://scenes/levels/level_3/level_4.tscn"
}

func from_prev_level(current_level: int = Globals.current_level) -> void:
	var label: Label = get_node("Label")
	label.text = texts[current_level]
	
	self.color.a = 255
	label.label_settings.font_color.a = 255
	
	var animation: AnimationPlayer = get_node("AnimationPlayer")
	animation.play("fade_out")
	await get_tree().create_timer(0.5).timeout

func to_next_level(current_level: int = Globals.current_level):
	var label: Label = get_node("Label")
	label.text = texts[current_level]
	
	var animation: AnimationPlayer = get_node("AnimationPlayer")
	animation.play("fade_in")
	await get_tree().create_timer(0.5).timeout

func reset_all(current_level: int = Globals.current_level):
	var label: Label = get_node("Label")
	label.text = texts[current_level]
	
	self.color.a = 255
	label.label_settings.font_color.a = 255
