#tThis should have paths all over that have randomnly falling tiles
extends Node2D

const PATH = preload("res://path_manager.gd")
var player
var lastpos = Vector2(0, 0)
var tilewidth = 100
var tileheight = 100
var tiles = {}
var paths = {}
var dead = []



func _fixed_process(delta):
	var camerapos = get_parent().camera.get_pos()
	var pos = player.get_pos()
	#if camerapos.x>pos.x:
	pos.x = camerapos.x
	#reduce this to only increment in regular units
	pos.y = -floor(int(pos.y)/tileheight)
	pos.x += 5 * tilewidth
	pos.x = floor(int(pos.x)/tilewidth)
	if (pos.x != lastpos.x):
		lastpos.x = pos.x
		for i in paths:
			if pos.y <= paths[i].height:
				var tile = paths[i].poll_tile(pos)
				tiles[pos + Vector2(0, i)] = tile
				add_child(tile)
	if (pos.y > lastpos.y):
		lastpos.y = pos.y
		if not paths.has(pos.y+2):
			paths[pos.y+2] = PATH.new(pos.y + 2)
			
		for i in paths:
			if pos.y>i: 
				dead.append(i)
		for i in range(dead.size()):
			paths.erase(dead[i])
		dead.clear()

	for i in tiles:
		if camerapos.x>tiles[i].pos.x+(tilewidth*(tiles[i].pathID-pos.y)*2): 
			if not tiles[i].falling:
				tiles[i].set_falling(false)
		#tiles that fall as a result of the path falling
		#fall more randomnly
		if abs(pos.y)>tiles[i].pathID:
			if not tiles[i].falling:
				tiles[i].set_falling(true)
		
		if tiles[i].pos.x < camerapos.x-global.size.x*0.7:
			tiles[i].free()
			dead.append(i)
	for i in range(dead.size()):
		tiles.erase(dead[i])
	dead.clear()

func _ready():
	paths[0] = PATH.new(0)
	paths[1] = PATH.new(1)
	paths[2] = PATH.new(2)
	for i in range(5):
		for j in paths:
			var pos = Vector2(i, j)
			var tile = paths[j].poll_tile(pos) 
			tiles[pos] = tile
			add_child(tile)
		
#		
	var base = get_parent()
	player = base.get_node("Player")
	
	set_fixed_process(true)


