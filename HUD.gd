
extends Control

var dist_label
var highscore_label
var message_label
var message_age = 0
var message_active = false

func update_distance(x):
	dist_label.set_text("Distance: " + x)
	
func set_highscore(x):
	highscore_label.set_text("Highscore: " + x)
	
func display_message(x):
	message_age = 0
	message_active = true
	message_label.set_text(x)
	
func _fixed_process(delta):
	message_age += delta
	if message_age > 2 and message_active:
		message_active = false
		message_label.set_text(" ")

func _ready():
	dist_label = get_node("layer/distance")
	highscore_label = get_node("layer/highscore")
	message_label = get_node("layer/message")
	set_fixed_process(true)


