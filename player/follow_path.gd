extends Node

var direction = 1

onready var path_follow_2d = $"../Path2D/PathFollow2D"
onready var character = $"../Character"


func _physics_process(delta):
	if path_follow_2d.unit_offset >= 0.99 && direction == 1:
		direction = -1
	elif path_follow_2d.unit_offset <= 0.01 && direction == -1:
		direction = 1
	
	var path_direction = Vector2(cos(path_follow_2d.rotation), sin(path_follow_2d.rotation))
	path_direction = path_direction * direction

	var oldPosition = character.position
	character.move(delta, path_direction)
	var currentPosition = character.position
	var distance = currentPosition.distance_to(oldPosition)
	path_follow_2d.offset += distance * direction

	if character.position.distance_to(path_follow_2d.position) > 2:
		character.position = path_follow_2d.position
