
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"
func _fixed_process(delta):
	print("located at" + str(get_pos()))

func _ready():
	set_fixed_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass


