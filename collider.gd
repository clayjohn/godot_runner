
extends StaticBody2D

var falling = false
var time = 0
var counting = false
var initial_pos
var initial_rot

func start_falling():
	#set_one_way_collision_direction(Vector2(0, 1))
	falling = true
	counting = true
	initial_pos = get_pos()
	initial_rot = get_rot()

func _fixed_process(delta):
	if falling:
		set_rot(initial_rot + time)
		initial_pos = get_pos()
		set_pos(initial_pos+Vector2(0.0, (time*5)))
		time += delta
	

func _ready():
	set_fixed_process(true)



