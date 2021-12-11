extends Control


class_name LevelUI

onready var main_meter_label :Label = $main_meter
onready var coin_label :Label = $coin
onready var time_label :Label = $time

func _ready() :
	$best_meter.text = "0.0m"
	pass

func set_meter(meter:float) :
	main_meter_label.text = "%.1fm"%meter

func set_time(time:int) :
	time_label.text = "time: %d"%time

func game_over(score:int, coin:int) :
	$GameOver.visible = true
	$GameOver/score.text = "%dm"%score
	$GameOver/coin.text = "+ %dwon"%coin

func _on_replayBtn_pressed():
	pass # Replace with function body.


func _on_homeBtn_pressed():
	pass # Replace with function body.

