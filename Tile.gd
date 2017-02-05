#Tile could turn into a full blown scene
#It could handle the falling of the floor along with particle system
extends Node2D

var pos
var type
var node
var falling = false

func set_falling():
	falling = true
	node.start_falling()

func _ready():
	pass
	
func _init(p, n):
	pos = p
	node = n
	set_pos(p)
	add_child(node)


