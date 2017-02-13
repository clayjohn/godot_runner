
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var posx = 0
var speed = 100
var diff
var player

#maybe make camera lead by a vector based on movement vector
func _fixed_process(delta):
	posx += delta*speed
	
	var pp = player.get_pos()
	#posx = max(pp.x, posx)
	diff = get_pos()-pp
	diff.y+=200
	if diff.y<0:
		diff.y=0
	set_pos(Vector2(posx, get_pos().y)-(diff*delta))
	
	if(Input.is_action_pressed("debug")):
		#print(posx)
		print(diff.y)
		#print(pp.y)
	
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var base = get_parent()
	player = base.get_node("Player")
	set_pos(player.get_pos()+Vector2(0, -200))
	set_fixed_process(true)


