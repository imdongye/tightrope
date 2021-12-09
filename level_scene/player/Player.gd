# limdongye 20211203
# application of Pendulum

class_name Player

extends Spatial

var bodyRad = 0.0
var groundRad = -PI/2
var bodyLength = 200.0 # tall make lower acceleration
var a_vel = 0.0 # angle
var a_acc = 0.0
var damping = 0.995 # resistance
var dia
var gravity = 0.4

enum State {STATE_IDLE, STATE_WALK, STATE_SITDOWN}
var plyaer_state = State.STATE_SITDOWN;


export (int) var move_speed := 2

onready var isAndroid :bool= OS.get_name() == "Android"
onready var player_animation :AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	print(isAndroid if "Game on Android" else "Game on Windows")
	bodyRad = rotation.z + PI/2


func _input(event):
	if (event is InputEventScreenTouch) or (event is InputEventMouseButton):
		# init state 
		if event.pressed == true:
			plyaer_state = State.STATE_WALK
			player_animation.play("walk")
		elif event.pressed == false:
			plyaer_state = State.STATE_SITDOWN
			a_vel = 0.0
			player_animation.play("sit_down")
			

func balancing(delta):
	if isAndroid:
		# it's same as opengl right hand cordination 
		var acc_sensor = Input.get_accelerometer()
		groundRad = atan2(acc_sensor.y, acc_sensor.x);
	else:
		# TODO : need more Intuitive control
		var sc_size = get_viewport().get_visible_rect().size
		var mouseX = get_viewport().get_mouse_position().x
		var offrad = PI * 0.1
		groundRad = range_lerp(mouseX, 0, sc_size.x, PI + offrad, 2*PI -offrad)
	
	var t_force = (-gravity/bodyLength) * cos(bodyRad-groundRad)
	a_acc = (-gravity/bodyLength) * sin(bodyRad-groundRad)
	a_vel += a_acc
	a_vel *= damping
	bodyRad += a_vel
	
	rotation.z = bodyRad - PI/2
	
func move(delta):
	translation.z -= move_speed * delta 


func _physics_process(delta):
	
	if plyaer_state == State.STATE_WALK:
		balancing(delta)
		move(delta)
		pass
	elif plyaer_state == State.STATE_SITDOWN:
		pass
