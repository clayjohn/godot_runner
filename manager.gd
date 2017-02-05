
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var static_floor = preload("res://static_platform.tscn")
var obstacle = preload("res://Obstacle.tscn")
var faller = preload("res://faller.tscn")
const TILE = preload("res://Tile.gd")
var player
var lastpos = Vector2(0, 0)
var tilewidth = 100
var tileheight = 50 #make this max jump height
var tiles = []
var num_solid = 0
var num_empty = 0

	

func _fixed_process(delta):
	var camerapos = get_parent().camera.get_pos()
	var pos = player.get_pos()
	if camerapos.x>pos.x:
		pos = camerapos
	pos.x+=3*tilewidth
	pos.x = floor(int(pos.x)/tilewidth)
	if (pos.x!=lastpos.x):
		lastpos.x = pos.x
	
		pos.x*=tilewidth
		pos.x+=0.5*tilewidth
			
		pos.y=lastpos.y
		lastpos.y = pos.y
		var node
		if ((rand_range(0, 10)<9 and num_solid<10)or num_empty>=3):
				
			if rand_range(0,10)<1:
				node = obstacle.instance()
			else:
				node = static_floor.instance()
			var tile = TILE.new(pos, node)
			tiles.append(tile)
			add_child(tile)
			num_solid+=1
			num_empty = 0
		else:
			node = faller.instance()
			var tile = TILE.new(pos, node)
			tiles.append(tile)
			add_child(tile)
			num_empty+=1
			num_solid=0
	for i in range(tiles.size()):
		if camerapos.x>tiles[i].pos.x:
			if not tiles[i].falling:
				tiles[i].set_falling()
	if (tiles.size()>6):
		tiles[0].free()
		tiles.remove(0)
		

func _ready():
	var base = get_parent()
	player = base.get_node("Player")
	
	set_fixed_process(true)


