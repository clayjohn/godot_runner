
extends Control

func _fixed_process(delta):
	var escape = Input.is_action_pressed("close_app")
	if global.paused:
		get_node("layer/Control").show()
	
func _resume():
	global.paused = false
	get_node("layer/Control").hide()
	get_tree().set_pause(false)
	

func _quit():
	get_tree().quit()

func _ready():
	get_node("layer/Control/quit").connect("pressed", self, "_quit")
	get_node("layer/Control/resume").connect("pressed", self, "_resume")
	set_fixed_process(true)


