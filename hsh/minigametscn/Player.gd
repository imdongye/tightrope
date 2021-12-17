extends KinematicBody2D

onready var variables = get_node("/root/ToVariable")
onready var hit_sound = $hit
onready var shoot_sound = $shoot

export (PackedScene) var Bullet
export var speed = 400
var velocity = Vector2()
		
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func exp_coin():
	return variables.player_coin
func exp_point():
	return variables.player_point
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	velocity = velocity.normalized()*speed
	
func _unhandled_input(event):
	if $"..".notify_bar() == false :	
		if event.is_action_pressed("click"):
			$"..".bar_stop()
			print(variables.target)
			shoot()
	
func shoot():
	shoot_sound.play()
	var bullet = Bullet.instance()
	bullet.intensity = $"../bar".value
	$"/root/MiniGame".add_child(bullet)
	$Muzzle.look_at(variables.target)
	bullet.transform = $Muzzle.global_transform
	
	variables.player_coin -= 1
	var coinlabel = $"../UI/coinLabel"
	coinlabel.text = "Coin : " + String(variables.player_coin)
	
	$"..".bar_start()
	$"../direction".visible = false
	
func hit_enemy():
	hit_sound.play()
	variables.player_point += 1
	var pointlabel = $"../UI/pointLabel"
	pointlabel.text = "Point : " + String(variables.player_point)
	
