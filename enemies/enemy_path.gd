extends Path2D

var direction = 1

onready var path_follow_2d = $PathFollow2D


func _physics_process(delta):
	if path_follow_2d.unit_offset >= 0.95 && direction == 1:
		direction = -1
	elif path_follow_2d.unit_offset <= 0.05 && direction == -1:
		direction = 1
	
	path_follow_2d.offset += delta * 25 * direction
