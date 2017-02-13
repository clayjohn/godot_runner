
extends Node2D

var parent
var diff
var pos


func _fixed_process(delta):
	pos.x += delta*parent.speed*0.7
	#pos.y = parent.get_pos().y
	var cpos = parent.get_node("camera").get_camera_pos()
	var ppos = cpos-parent.get_pos()+parent.diff*delta
	
	var target = Vector2(-0.5, 0.5)*global.size
	diff = (pos-parent.get_pos())
	pos -= diff*delta*2
	set_pos(ppos+target+diff*3)
	
	

func _ready():
	parent = get_parent()
	pos = Vector2(0, 0)
	
	set_fixed_process(true)


