extends Area2D

var speed = 1350
var intensity = 0


func _on_Bullet_body_entered(body):
	if body is Enemies:
		$"../Player".hit_enemy()
		body.queue_free()
	
func _physics_process(delta):
	if intensity > 0 :
		position += transform.x * speed * delta
	intensity -= 5
	if intensity < -8 :
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
