extends Timer

var rng = RandomNumberGenerator.new()

func ready() :
	rng.randomize()
	
func _process(delta):
	set_wait_time(rng.randf_range(1.0, 2.0))
