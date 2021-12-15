extends Control

onready var cur_hat = get_node("/root/Global")

func _on_Button1_pressed():
	$Clicksound.play()
	print("button 1 choosed")
	cur_hat.hat = 0

func _on_Button2_pressed():
	print("button 2 choosed")
	cur_hat.hat = 1
	$Clicksound.play()
	
func _on_Button3_pressed():
	print("button 3 choosed")
	cur_hat.hat = 2
	$Clicksound.play()
	
func _on_Button4_pressed():
	print("button 4 choosed")
	cur_hat.hat = 3
	$Clicksound.play()
	
func _on_Button5_pressed():
	print("button 5 choosed")
	cur_hat.hat = 4
	$Clicksound.play()
	
var main = preload("res://Game.tscn")

func _on_GobackButton_pressed():
	get_tree().change_scene_to(main)
	$Clicksound.play()
