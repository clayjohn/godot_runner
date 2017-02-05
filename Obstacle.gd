
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func start_falling():
	get_node("static_platform").start_falling()
	get_node("ridge").start_falling()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


