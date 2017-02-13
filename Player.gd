extends KinematicBody2D


#the code is borrowed from the tutorial
#==================================#

# This is a simple collision demo showing how
# the kinematic controller works.
# move() will allow to move the node, and will
# always move it to a non-colliding spot,
# as long as it starts from a non-colliding spot too.

# Member variables
const GRAVITY = 400.0 # Pixels/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 60
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
var WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 220
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # One pixel per second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # One pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false
var double_jumping = false

var dropped_platform = null
var last_platform = null

var prev_jump_pressed = false
var prev_colliding = false

var autowalk = false

func _input(event):
#	if event.type == InputEvent.SCREEN_TOUCH or event.type == InputEvent.SCREEN_DRAG:
#		if event.x>512:
#			print("touching")
#		elif event.x<512:
#			print("leffft")
#	if event.type == InputEvent.MOUSE_BUTTON:
#		if event.x>512:
	#			print("touch"pass)
	pass

func _fixed_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	var mouse_move = false
	var mouse_jump = false
	if Input.is_mouse_button_pressed(1):
		var mouse_pos = get_viewport().get_mouse_pos()
		var screen = get_viewport().get_rect().size
		if mouse_pos.y<screen.y*0.5:
			mouse_move = true
		else:
			mouse_jump = true
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right") or autowalk or mouse_move
	var jump = Input.is_action_pressed("jump") or mouse_jump
	var drop = Input.is_action_pressed("move_down")
	
	var stop = true
	
	if (walk_left):
		if (velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED):
			force.x -= WALK_FORCE
			stop = false
	elif (walk_right):
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED):
			force.x += WALK_FORCE
			stop = false
	
	if (stop):
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE*delta
		if (vlen < 0):
			vlen = 0
		
		velocity.x = vlen*vsign
	
	# Integrate forces to velocity
	velocity += force*delta
	
	# Integrate velocity into motion and move
	var motion = velocity*delta
	
	# Move and consume motion
	motion = move(motion)
	var floor_velocity = Vector2()
	
	if (is_colliding()):
		
		var platform = get_collider()
		jumping = false
		double_jumping = false 
		# You can check which tile was collision against with this
		if(dropped_platform != null and dropped_platform != platform):
			dropped_platform.set_one_way_collision_direction(Vector2(0, 1))
			dropped_platform = null
		# Ran against something, is it the floor? Get normal
		var n = get_collision_normal()
		
		
		if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			# If angle to the "up" vectors is < angle tolerance
			# char is on floor
			if not prev_colliding:
				get_node("poof").set_emitting(true)
			if abs(velocity.x)>0.1:
				get_node("trail").set_emitting(true)
			else:
				get_node("trail").set_emitting(false)
			on_air_time = 0
			floor_velocity = get_collider_velocity()
			if (drop):
				platform.set_one_way_collision_direction(Vector2(0, -1))
				dropped_platform = platform
		
		if (not jump and on_air_time == 0 and force.x == 0 and get_travel().length() < SLIDE_STOP_MIN_TRAVEL and abs(velocity.x) < SLIDE_STOP_VELOCITY and get_collider_velocity() == Vector2()):
			# Since this formula will always slide the character around, 
			# a special case must be considered to to stop it from moving 
			# if standing on an inclined floor. Conditions are:
			# 1) Standing on floor (on_air_time == 0)
			# 2) Did not move more than one pixel (get_travel().length() < SLIDE_STOP_MIN_TRAVEL)
			# 3) Not moving horizontally (abs(velocity.x) < SLIDE_STOP_VELOCITY)
			# 4) Collider is not moving
			revert_motion()
			velocity.y = 0.0
		else:
			# For every other case of motion, our motion was interrupted.
			# Try to complete the motion by "sliding" by the normal
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			# Then move again
			move(motion)
		prev_colliding = true
	
	if (floor_velocity != Vector2()):
		# If floor moves, move with floor
		move(floor_velocity*delta)
	
	#if (jumping and velocity.y > 0):
		# If falling, no longer jumping
	#	jumping = false
		
	if (jumping and not double_jumping and jump and not prev_jump_pressed):
		velocity.y = -JUMP_SPEED
		double_jumping = true
		prev_colliding = false
		
	
	if (jump and not prev_jump_pressed and (not jumping and not double_jumping)):
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		##figure out jumping issue
		#move(velocity*delta)
		jumping = true
		prev_colliding = false
		get_node("trail").set_emitting(false)
	
	on_air_time += delta
	prev_jump_pressed = jump


func _ready():
	set_fixed_process(true)
	set_process_input(true)