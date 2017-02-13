
extends ParallaxBackground

var mtn = preload("res://mountain.gd")
var building_material = preload("buildingMat.tres")

var background_width = 1100
var background_height = 600

const layerHeight = 100

func add_layer(y):
	var pl = ParallaxLayer.new()
	var image = Node2D.new()
	var mat = building_material.duplicate()
	image.set_script(mtn)
	image.width = 500
	#set parameters to generation here
	pl.set_pos(Vector2(0, 300-y*layerHeight))
	pl.set_motion_scale(Vector2(1.0/(y+1.0), 1))
	pl.set_mirroring(Vector2(1100, 700)) #1000 is a magic number for now
			#should be replaced with a smarter number later
			#also the y mirror should probably not happen, instead there should be changing scenery
	mat.set_shader_param("blue", 0.25*y)
	mat.set_shader_param("ypos", y*layerHeight)
	image.set_material(mat)
	pl.add_child(image)
	add_child(pl)

func _ready():
	for i in range(6):
		add_layer(5-i)


