
extends StaticBody2D

#for this one make sure it does some collision with the player but falls at the same
#rate it should probably be a kinematic body then
var falling = false
var time = 0
var counting = false
var initial_pos
var initial_rot

func start_falling():
	set_one_way_collision_direction(Vector2(0, 0))
	falling = true
	counting = true
	initial_pos = get_pos()
	initial_rot = get_rot()

func _fixed_process(delta):
	if falling:
		get_node("Particles2D").set_emitting(true)
		set_rot(initial_rot + time)
		initial_pos = get_pos()
		set_pos(initial_pos+Vector2(0.0, (time*5)))
		time += delta
	

func _ready():
	set_fixed_process(true)


