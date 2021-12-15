extends Button


var level = preload("res://hsh/minigametscn/MiniGame.tscn")


func _on_B2_pressed():
	get_tree().change_scene_to(level)
