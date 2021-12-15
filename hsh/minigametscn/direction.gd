extends Node2D

var speed = 250
onready var variables = get_node("/root/ToVariable.gd")
var right = true

var player_point = 0
var player_coin = 3
var target = Vector2(0, 0)
	
func _process(delta):
		
	if right == false :
		 $direcPath/PathFollow2D.offset -= 3
	else :
		$direcPath/PathFollow2D.offset += 3
	
	
	if $direcPath/PathFollow2D.offset > 400 :
		right = false
	elif $direcPath/PathFollow2D.offset < 3 :
		right = true

	target.x = $direcPath/PathFollow2D.position.x - 202 + 434
	target.y = $direcPath/PathFollow2D.position.y - 253 + 2034
	#directionPath/PathFollow2D.position 시작 위치 + minigame의 direction 시작 위치
