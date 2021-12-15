extends Node2D

onready var variables = get_node("/root/ToVariable")

func _ready():
	var coin = $ColorRect/ColorRect/remcoin
	coin.text += String(variables.player_coin)
	var point = $ColorRect/ColorRect/getpoint
	point.text += String(variables.player_point)
