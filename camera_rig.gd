
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var posx = 0
var speed = 100

#maybe make camera lead by a vector based on movement vector
func _fixed_process(delta):
	posx += delta*speed
	var base = get_parent()
	var player = base.get_node("Player")
	var pp = player.get_pos()
	posx = max(pp.x, posx)
	set_pos(Vector2(posx, pp.y))
	
	if(Input.is_action_pressed("debug")):
		print(posx)
	
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)


