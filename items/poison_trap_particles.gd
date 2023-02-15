extends CPUParticles2D


func _ready():
	emitting = true
	var time: float = (lifetime * 2) / speed_scale
	var _result = get_tree().create_timer(time).connect("timeout",Callable(self,"queue_free"))
