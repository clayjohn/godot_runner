#paths are defined by their y value
#to begin with all paths should be flat with random gaps in them
#but later add diagonal paths and vertical obstacles
#this idea will be for the main game mode

const TILE = preload("res://Tile.gd")
var static_floor = preload("res://static_platform.tscn")
var obstacle = preload("res://Obstacle.tscn")
var faller = preload("res://faller.tscn")
var tilewidth = 100
var tileheight = 100
var height = 0#in path units//ID
var last_pos = Vector2(0, 0)
var num_solid = 0
var num_empty = 0
var last_type
var height_diff = 0

func poll_tile(pos):
	var rh = max(pos.y, 0)
	pos.y = -height * tileheight 
	last_pos = pos
	pos.x*=tilewidth
	var node
	if ((rand_range(0, 10)<9 and num_solid<10)or num_empty>=3):
		if rand_range(0,10)<1:
			node = obstacle.instance()
			last_type = "obstacle"
		else:
			node = static_floor.instance()
			last_type = "static_floor"
		num_solid+=1
		num_empty = 0
	else:
		node = faller.instance()
		last_type = "faller"
		num_empty+=1
		num_solid=0
	return TILE.new(pos, node, height, rh-height)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _init(h):
	height = h


