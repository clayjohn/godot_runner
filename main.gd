#need to have a death state
# and a pause menu state

extends Node2D

var player
var camera
var HUD
var speed_modifier = 0.8
var distance = 0.0
var highscore
var passed_highscore = false


func _fixed_process(delta):
	#check if need to exit
	var escape = Input.is_action_pressed("close_app")
	if (escape):
		global.paused = true
		get_tree().set_pause(true)
		#get_tree().quit()
	randomize()
	#increase player speed as game progresses
	#camera speed should update at the same time
	distance = player.get_pos().x
	HUD.update_distance(str(int(distance)))
	HUD.update_fps(str(int(OS.get_frames_per_second())))
	if (distance > highscore):
		if not passed_highscore:
			HUD.display_message("NEW HIGHSCORE!")
		passed_highscore = true
		highscore = int(distance)
		HUD.set_highscore(str(highscore))
	
	if (player.get_pos().y>camera.get_pos().y+500 or distance<camera.get_pos().x-600):
		get_tree().change_scene("res://death_state.tscn")
		global.highscore = highscore
		global.lastscore = distance

	player.WALK_MAX_SPEED = 200+200*(player.get_pos().x/20000.0)
	camera.speed = player.WALK_MAX_SPEED*speed_modifier

func _ready():
	set_fixed_process(true)
	player = get_node("Player")
	camera = get_node("camera_rig")
	HUD = get_node("HUD")
	var savegame = File.new()
	if savegame.file_exists("highscore.save"):
		savegame.open("highscore.save", File.READ)
		highscore = savegame.get_line().to_int()
		HUD.set_highscore(str(highscore))
	if get_parent().get_name() == "autopilot":
		player.autowalk = true

func _exit_tree():
	var savegame = File.new()
	if not savegame.file_exists("highscore.save"):
		print("creating highscore file")
	savegame.open("highscore.save", File.WRITE)
	savegame.store_string(str(highscore))
	savegame.close()

