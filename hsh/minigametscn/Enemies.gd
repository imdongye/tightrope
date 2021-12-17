extends KinematicBody2D

class_name Enemies

export var speed = 100

func _ready():
	randomize()
	
func _physics_process(delta):
	position -= transform.x * speed * delta
	
func _on_VisibilityNotifier2D_screen_exited(): 
	queue_free()
