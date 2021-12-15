# limdongye 2021.12.03
# application of Pendulum

## < TODO LIST > ##
# 1. add game over falling cut $
# 2. prevent to turnover the phone $
# 3. jump animation $
# 4. bird animation
# 5. collision check in LevelScene
# 6. distrubing power when jump and windy
# 7. add Coin
# 8. combine other scene
# 9. add sum

## < WISH LIST > ##
# 0. player is over painting when under the rope
#	becouse painters algorithm for sprite
# 1. pivot to rigid body

class_name Player

extends Spatial
#hat
onready var hatSprite = $RigidBody/ImgPivot/Body/Hat

onready var cur_hat = get_node("/root/Global")

var hats_sprites = preload("res://hatspirtes.gd").new()

# Pendulum variable
var body_rad = 0.0
var ground_rad = -PI/2
var bodyLength = 200.0 # tall make lower acceleration
var a_vel = 0.0 # angle
var a_acc = 0.0
var damping = 0.995 # resistance
var dia
var gravity = 0.4
var wind_force = 0.0

# Player State
enum State {STATE_PAUSE, STATE_WALK, STATE_SITDOWN, STATE_JUMP, STATE_FALLING}
var player_state = State.STATE_SITDOWN;

onready var is_android :bool= OS.get_name() == "Android"
onready var player_animation :AnimationPlayer = $"AnimationPlayer" # get_node()
onready var level_ui : LevelUI = $"../LevelUI"
onready var screen_size := get_viewport().get_visible_rect().size
onready var jump_yoffset := screen_size.y*0.26 

export (int) var move_speed := 2
var cur_meter := 0.0
var over_counter := 0.0 # bad method
var touch_start_ypos := 0


func _ready():
	print("Game on Android" if is_android else "Game on Windows")
	body_rad = rotation.z + PI/2
	if cur_hat.hat != null:
		hatSprite.texture = hats_sprites.hat_spritesheet[cur_hat.hat]

func _input(event):
	if player_state in [State.STATE_FALLING, State.STATE_JUMP, State.STATE_PAUSE] :
		return
		
	if (event is InputEventScreenTouch) or (event is InputEventMouseButton):
		# init state 
		if event.pressed == true:
			player_state = State.STATE_WALK
			player_animation.play("walk")
			touch_start_ypos = event.get_position().y

		elif event.pressed == false:
			var diff_y = touch_start_ypos - event.get_position().y
			if diff_y > jump_yoffset:
				player_state = State.STATE_JUMP
				a_vel = 0.0
				player_animation.play("jump")
				$JumpAudio.play()
			else :	
				player_state = State.STATE_SITDOWN
				a_vel = 0.0
				player_animation.play("sit_down")
	
func balancing(delta):
	if is_android:
		# it's same as opengl right hand coordination 
		var acc_sensor = Input.get_accelerometer() 
		ground_rad = atan2(acc_sensor.y, acc_sensor.x);
	else:
		# TODO : need more Intuitive control
		var sc_size = get_viewport().get_visible_rect().size
		var mouseX = get_viewport().get_mouse_position().x
		var offrad = PI * 0.1
		ground_rad = range_lerp(mouseX, 0, sc_size.x, 2*PI -offrad, PI + offrad)
	
	##var t_force = (-gravity/bodyLength) * cos(body_rad-ground_rad)
	a_acc = (-gravity/bodyLength) * sin(body_rad-ground_rad)
	a_acc -= wind_force # positive is right, negative is left
	a_vel += a_acc
	a_vel *= damping
	body_rad += a_vel
	rotation.z = body_rad - PI/2

func move(delta):
	translation.z -= move_speed * delta
	
func set_wind(spd:float) :
	wind_force = spd

func set_fall() :
	player_state = State.STATE_FALLING
	$RigidBody.mode = RigidBody.MODE_RIGID
	$FallAudio.play()

func add_coin() :
	get_parent().add_coin()

func _on_landing() :
	player_state = State.STATE_WALK
	player_animation.play("walk")

func _physics_process(delta):
	if player_state == State.STATE_PAUSE:
		return
	
	if player_state == State.STATE_WALK:
		balancing(delta)
		move(delta)
		if body_rad > PI or 0 > body_rad:
			set_fall()
			
	if player_state == State.STATE_SITDOWN:
		pass
	if player_state == State.STATE_FALLING:
		over_counter += delta
		if over_counter > 1.0:
			get_parent().game_over()
		pass
	if player_state == State.STATE_SITDOWN or player_state == State.STATE_WALK:
		pass
