extends Button


var level = preload("res://level_scene/level_scene.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(level)

