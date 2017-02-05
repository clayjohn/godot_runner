
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _draw():
	for i in range(10):
		draw_rect(Rect2(i*100, 0, 100, -rand_range(75, 150)), Color(0.4, 0.6, 0.9)) 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


