extends Control


class_name LevelUI

onready var main_meter_label :Label = $main_meter
onready var best_meter_label :Label = $best_meter
onready var coin_label :Label = $coin
onready var time_label :Label = $time

var home_scene
var level_scene



func _ready() :
	$best_meter.text = "0.0m"
	$GameOver.visible = false
	$Cheating.visible = false
	$Credit.visible = false
	pass

func set_meter(meter:float) :
	main_meter_label.text = "%.1fm"%meter

func set_best_meter(meter:float) :
	best_meter_label.text = "%.1fm"%meter

func set_time(time:int) :
	time_label.text = "time: %d"%time
	
func set_coin(coin:int):
	coin_label.text = ": %d"%coin

func set_game_over(score:int, coin:int, is_best:bool) :
	$GameOver.visible = true
	$GameOver/score.text = "%dm"%score
	$GameOver/coin.text = "+ %dwon"%coin
	$GameOver/explan.text = "new score"  if is_best else "too bad"
	
	level_scene = load("res://level_scene/level_scene.tscn")
	home_scene = load("res://Game.tscn")
	
func set_state_text(text:String) :
	$state.text = text
	
func set_cheating(check:bool) :
	$Cheating.visible = check

func _on_replayBtn_pressed():
	print("replay btn")
	get_tree().change_scene_to(level_scene)


func _on_homeBtn_pressed():
	print("replay btn")
	get_tree().change_scene_to(home_scene)


func _on_credit_back_pressed():
	$Credit.visible = false
	pass # Replace with function body.


func _on_creditBtn_pressed():
	$Credit.visible = true
	pass # Replace with function body.


func _on_muteBtn_pressed():
	get_parent().mute()
	pass # Replace with function body.


func _on_muteBtn_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)
