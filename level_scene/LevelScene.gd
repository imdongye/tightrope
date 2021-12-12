extends Spatial


class_name LevelScene


onready var level_ui : LevelUI = $LevelUI
onready var player : Player = $Player


enum State {STATE_PLAY, STATE_PAUSE}
var game_state = State.STATE_PLAY;

var time_sec := 0.0
var start_z_pos := 0.0
var meter := 0.0
var ns_coin := 0
var best_meter : = 0.0

var score_file = "user://score.save"

func save_to_file():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(meter, false)
	file.close()


func load_from_file():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		best_meter = file.get_var(false)
		file.close()

func _ready():
	start_z_pos = player.translation.z
	load_from_file()
	level_ui.set_best_meter(best_meter)
	pass

func add_coin() :
	ns_coin += 1
	level_ui.set_coin(ns_coin)
	
func check_cheating() :
	if player.is_android == false :
		return
	
	var acc_sensor = Input.get_accelerometer()
	var offset = -0.1
	
	if player.player_state == player.State.STATE_WALK and acc_sensor.y > offset:
		player.player_state = player.State.STATE_PAUSE
		print("cheating")
		game_state = State.STATE_PAUSE
		level_ui.set_cheating(true)
		
	elif player.player_state == player.State.STATE_PAUSE and acc_sensor.y < offset-0.1:
		player.player_state = player.State.STATE_WALK
		print("cheating back")
		game_state = State.STATE_PLAY
		level_ui.set_cheating(false)

func game_over():
	game_state = State.STATE_PAUSE
	var is_best = false
	if meter > best_meter:
		save_to_file()
		is_best = true
	level_ui.set_game_over(meter, ns_coin, is_best)

func _physics_process(delta):
	check_cheating()
	
	if game_state == State.STATE_PAUSE :
		return
		
	## Play ##
	time_sec += delta
	level_ui.set_time(time_sec)
	meter = player.translation.z - start_z_pos
	meter = abs(meter*0.5)
	level_ui.set_meter(meter)
