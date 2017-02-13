
extends Node2D

var num_boxes = 11
var width = 1100
var height = 150

#this is not the most efficient thing to do, but it should work
func _draw():
	var box_width = width/num_boxes
	var partx = 1/num_boxes
	
	var colors = ColorArray()
	colors.append(Color(1.0, 0.0, 0.0))
	colors.append(Color(1.0, 0.0, 0.0))
	colors.append(Color(1.0, 0.0, 0.0))
	colors.append(Color(1.0, 0.0, 0.0))
	for i in range(num_boxes):
		var h = -rand_range(height*0.5, height)
		var party = abs(h)/height
		##make these once and then just increment the locations
		var points = Vector2Array()
		points.append(Vector2(i*box_width, 0))
		points.append(Vector2(i*box_width+box_width, 0))
		points.append(Vector2(i*box_width+box_width, h))
		points.append(Vector2(i*box_width, h))
		var uvs = Vector2Array()
		uvs.append(Vector2(i*partx, 0))
		uvs.append(Vector2((i+1)*partx, 0))
		uvs.append(Vector2((i+1)*partx, party))
		uvs.append(Vector2(i*partx, party))
		
		draw_primitive(points, colors, uvs)
		#admittedly this is way uglier than rect, but we need the uvs
		#draw_rect(Rect2(i*box_width, 0, box_width, -rand_range(height*0.5, height)), Color(0.4, 0.6, 0.9)) 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


