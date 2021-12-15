extends Camera

class_name CameraCtrl

export var lerp_speed = 3.0
export (NodePath) var target_path = null
export (float) var zoom_in_max = 50.5
export (float) var zoom_out_max = 88.0

onready var player :Player = $"../Player"
var distance_from_player := Vector3(0, 0, 0)

func _ready():
	distance_from_player = translation - player.translation
	pass
	
func set_zoom_by_angle(rad : float) :
	var t_fov = range_lerp(abs(rad-PI/2), 0, PI/2, zoom_in_max, zoom_out_max)
	t_fov = clamp(t_fov, zoom_in_max, zoom_out_max)
	fov= t_fov
	

func _physics_process(delta):
	if !player:
		return
	var target_pos = player.translation + distance_from_player
	
	set_zoom_by_angle(player.body_rad)
	# TODO : lerp this
	translation = target_pos
