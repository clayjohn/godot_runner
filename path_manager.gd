
extends Node

#this shouldnt be a node
#it should just be a class like Tile
#also this should likely contain tile

#paths are defined by their y value
#to begin with all paths should be flat with random gaps in them
#but later add diagonal paths and vertical obstacles

# path just has information for when to add tiles and when to remove them
# manage will query this for creating and destroying tiles
# but manager will manage what happens with the tiles

class path:
	var tiles
	var height #in path units//ID
	var last_pos
	var num_solid
	var num_empty
	var last_type
	
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


