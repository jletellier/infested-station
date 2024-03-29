extends Node

const Character := preload("res://characters/character.gd")

@export var path := NodePath()
@export var loop: bool = false
@export var autorun: bool = true
@export var update_rotation: bool = true

var current_point_idx: int = 0
var target_point_idx: int = 0
var direction: int = 1

@onready var path_2d := get_node(path) as Path2D
@onready var curve := path_2d.curve
@onready var character := get_parent() as Character


func _ready() -> void:
	set_physics_process(autorun)


func _physics_process(delta: float) -> void:
	var point_count := curve.get_point_count()
	var current_point := path_2d.position + curve.get_point_position(current_point_idx)
	var old_position := character.position
	var path_direction := (current_point - old_position).normalized()

	if update_rotation:
		character.rotation = path_direction.angle()

	character.move(delta, path_direction)

	if character.position.distance_to(current_point) < 1:
		current_point_idx += direction
		if !autorun && current_point_idx == target_point_idx + direction:
			character.move(delta, Vector2.ZERO)
			set_physics_process(false)
		elif loop:
			current_point_idx = current_point_idx % point_count
		elif current_point_idx == 0 || current_point_idx == point_count - 1:
			direction *= -1


func set_target_point_idx(point_idx: int, skip_previous: bool = false) -> void:
	set_physics_process(true)
	target_point_idx = point_idx
	if skip_previous:
		current_point_idx = target_point_idx


func set_position_instantly(point_idx: int, idle_input_vector := Vector2.ZERO) -> void:
	set_physics_process(false)
	var current_point := path_2d.position + curve.get_point_position(point_idx)
	character.snapped_position = current_point
	character.position = current_point
	character.last_input_vector = Vector2.ZERO
	if idle_input_vector:
		character.idle_input_vector = idle_input_vector
	character.move(0, Vector2.ZERO)
