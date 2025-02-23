extends Area2D

@onready var shape = $Shape.shape

func resize(size):
	shape.size.y = size
