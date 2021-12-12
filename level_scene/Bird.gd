extends Spatial

class_name Bird


onready var bird_animation :AnimationPlayer = $"AnimationPlayer"

func _ready():
	bird_animation.play("flying")
	pass


func _on_Bird_body_entered(body):
	var player = body.get_parent() as Player
	player.set_fall()
