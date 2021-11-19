extends Node

const Character := preload("res://characters/character.gd")

export var path := NodePath()
export var loop: bool = false

var current_point_idx: int = 0
var direction: int = 1

onready var path_2d := get_node(path) as Path2D
onready var curve := path_2d.curve
onready var character := get_parent() as Character


func _physics_process(delta: float) -> void:
	var point_count := curve.get_point_count()
	var current_point := path_2d.position + curve.get_point_position(current_point_idx)
	var old_position := character.position
	var path_direction := (current_point - old_position).normalized()

	character.rotation = path_direction.angle()
	character.move(delta, path_direction)

	if character.position.distance_to(current_point) < 1:
		current_point_idx += direction
		if loop:
			current_point_idx = current_point_idx % point_count
		elif current_point_idx == 0 || current_point_idx == point_count - 1:
			direction *= -1
