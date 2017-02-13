
extends Node2D

func _fixed_process(delta):
	var ev = InputEvent()
	ev.type = InputEvent.ACTION
	ev.set_as_action("move_right", true)
	get_tree().input_event(ev)

func _ready():
	set_fixed_process(true)

