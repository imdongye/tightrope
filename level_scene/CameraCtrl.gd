extends Camera

class_name CameraCtrl

export var lerp_speed = 3.0
export (NodePath) var target_path = null

var player
var distance_from_player := Vector3(0, 0, 0)

func _ready():
	player = get_node(target_path) as Player	
	distance_from_player = translation - player.translation
	pass

func _physics_process(delta):
	if !player:
		return
	var target_pos = player.translation + distance_from_player
	# TODO : lerp this
	translation = target_pos
