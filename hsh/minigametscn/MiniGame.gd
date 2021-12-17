extends Node2D

onready var variables = get_node("/root/ToVariable")
onready var bar_sound = $barsound

var enemy = preload("res://hsh/minigametscn/Enemies.tscn")
var rng = RandomNumberGenerator.new()
export var barstart = true
var barcontrol = true

func ready():
	rng.randomize()
	
func _process(delta):
	if barstart == true :
		if $bar.value == $bar.min_value :
			barcontrol = true
		if $bar.value == $bar.max_value :
			barcontrol = false
		if barcontrol == true:
			$bar.value += 7
		if barcontrol == false:
			$bar.value -= 7

func _unhandled_input(event):
	if event.is_action_pressed("space"):
		if variables.player_coin == 0 :
			var lackcoin = $"UI/lackcoin"
			lackcoin.text = "No Coin"
			lackcoin.visible = true
		if variables.player_coin != 0 :
			bar_sound.play()
			bar_stop()
		
func bar_start():
	barstart = true
func bar_stop():
	barstart = false
	$direction.visible = true
func notify_bar():
	return barstart

	
func _on_enemytimer_timeout():
	$birdpath/birdfollowpath.offset = rng.randi_range(6450, 7578)
	
	var enemies = enemy.instance() 
	enemies.speed = rng.randi_range(80, 230)
	enemies.position.y = $birdpath/birdfollowpath.position.x
	enemies.position.x = 1000
	$enemytimer.wait_time = rng.randf_range(0.2, 0.8)
	
	add_child(enemies)
