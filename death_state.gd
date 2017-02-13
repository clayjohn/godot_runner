
extends Control

func _restart():
	get_tree().change_scene("res://speed_mode.tscn")
	
func _quit():
	get_tree().quit()
	
func _menu():
	get_tree().change_scene("res://main.tscn")

func _ready():
	get_node("highscore").set_text("Highscore:\n" + str(global.highscore))
	get_node("score").set_text("Score:\n" +str(int(global.lastscore)))
	get_node("restart").connect("pressed", self, "_restart")
	get_node("quit").connect("pressed", self, "_quit")
	get_node("main_menu").connect("pressed", self, "_menu")


