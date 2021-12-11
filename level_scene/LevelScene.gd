extends Spatial


class_name LevelScene


onready var level_ui : LevelUI = $LevelUI
onready var player : Player = $Player

var time_sec := 0.0
var start_z_pos := 0.0
var meter := 0.0
var ns_coin := 0

func _ready():
	start_z_pos = player.translation.z
	pass
	
func _physics_process(delta):
	time_sec += delta
	level_ui.set_time(time_sec)
	meter = player.translation.z - start_z_pos
	meter = abs(meter*0.5)
	level_ui.set_meter(meter)
	var body_rad = player.body_rad
	if body_rad > PI or 0 > body_rad:
		get_tree().paused = true
		level_ui.game_over(meter, ns_coin)
