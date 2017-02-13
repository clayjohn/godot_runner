
extends Node2D

var pos
var type
var node
var pathID
var life
var falling = false
var elapsed_fall_time = 0
var mod = 1

func set_falling(drop):
	if drop:
		life = randf()*3
	else:
		mod = 1 + randf()
	falling = true
	

func _fixed_process(delta):
	elapsed_fall_time += delta * mod
	if elapsed_fall_time > life:
		node.start_falling()
		set_fixed_process(false)

func _ready():
	pass
	
func _init(p, n, id, rh):
	pos = p
	node = n
	pathID = id
	set_pos(p)
	add_child(node)
	life = 1 + randf() * 3 * max(abs(rh), 1)
	set_fixed_process(true)


