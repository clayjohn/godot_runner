
extends Control

func _start():
	get_tree().change_scene("res://speed_mode.tscn")

func _reset():
	var savegame = File.new()
	savegame.open("highscore.save", File.WRITE)
	savegame.store_string("0")
	savegame.close()
	get_parent().get_node("autopilot/Node2D").highscore = 0
	
func _quit():
	get_tree().quit()

func _ready():
	get_node("layer/start").connect("pressed", self, "_start")
	get_node("layer/reset").connect("pressed", self, "_reset")
	get_node("layer/quit").connect("pressed", self, "_quit")
	


