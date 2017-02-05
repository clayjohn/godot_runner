
extends Camera2D

# member variables here, example:
# var a=2
# var b="textvar"
var distance = 0
var follow = 200

func _fixed_process(delta):

	var node = get_parent()
	var pos = get_camera_pos()
	if (abs(pos.x-node.get_pos().x)<1):
		follow = 0
	else:
		follow = 200
	var size = get_viewport().get_rect().size
	distance = max(pos.x-size.x*0.5-follow, distance)
	#set_limit(0, distance)

func _ready():
	set_fixed_process(false)
	


