
extends Node2D


func start_falling():
	get_node("static_platform").start_falling()
	get_node("ridge").start_falling()

func _ready():
	pass


