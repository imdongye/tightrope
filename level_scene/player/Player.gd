# limdongye 2021.12.03
# application of Pendulum

## < TODO LIST > ##
# -1. camera jooming, arm balancing Synchronization
# 0. UI things ( meter, health )
# 0.1 . game over
# 1. jump
# 2. distrubing power when jump and windy
# 3. collision check with coint and bird
# 4.

## < WISH LIST > ##
# 0. player is over painting when under the rope
#	becouse painters algorithm for sprite

class_name Player

extends Spatial

# Pendulum variable
var body_rad = 0.0
var ground_rad = -PI/2
var bodyLength = 200.0 # tall make lower acceleration
var a_vel = 0.0 # angle
var a_acc = 0.0
var damping = 0.995 # resistance
var dia
var gravity = 0.4

# Player State
enum State {STATE_IDLE, STATE_WALK, STATE_SITDOWN}
var plyaer_state = State.STATE_SITDOWN;

onready var is_android :bool= OS.get_name() == "Android"
onready var player_animation :AnimationPlayer = $"AnimationPlayer" # get_node()
onready var p_rigidbody : RigidBody = $RigidBody
onready var level_ui : LevelUI = $"../LevelUI"

export (int) var move_speed := 2
var cur_meter := 0.0


func _ready():
	print(is_android if "Game on Android" else "Game on Windows")
	body_rad = rotation.z + PI/2
	

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
	if is_android:
		# it's same as opengl right hand cordination 
		var acc_sensor = Input.get_accelerometer()
		ground_rad = atan2(acc_sensor.y, acc_sensor.x);
	else:
		# TODO : need more Intuitive control
		var sc_size = get_viewport().get_visible_rect().size
		var mouseX = get_viewport().get_mouse_position().x
		var offrad = PI * 0.1
		ground_rad = range_lerp(mouseX, 0, sc_size.x, 2*PI -offrad, PI + offrad)
	
	var t_force = (-gravity/bodyLength) * cos(body_rad-ground_rad)
	a_acc = (-gravity/bodyLength) * sin(body_rad-ground_rad)
	a_vel += a_acc
	a_vel *= damping
	body_rad += a_vel
	rotation.z = body_rad - PI/2
	
func move(delta):
	translation.z -= move_speed * delta 


func _physics_process(delta):
	if plyaer_state == State.STATE_WALK:
		balancing(delta)
		move(delta)
	elif plyaer_state == State.STATE_SITDOWN:
		pass
