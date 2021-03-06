
extends ParallaxBackground

var mtn = preload("res://mountain.gd")
var building_material = preload("buildingMat.tres")

var background_width
var background_height

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
	pl.set_mirroring(Vector2(background_width, background_height+100)) 
	mat.set_shader_param("blue", 0.25*y)
	mat.set_shader_param("ypos", y*layerHeight)
	image.set_material(mat)
	pl.add_child(image)
	add_child(pl)

func _ready():
	background_width = global.size.x
	background_height = global.size.y
	for i in range(6):
		add_layer(5-i)


