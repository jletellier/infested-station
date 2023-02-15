extends Node

const Character := preload("res://characters/character.gd")

var _target: Character = null

@onready var _character := get_parent() as Character


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	var old_position := _character.position
	var target_position := _target.position
	if _target.is_snapping_x:
		target_position.x = _target.snapped_position.x
	if _target.is_snapping_y:
		target_position.y = _target.snapped_position.y

	var path_direction := Vector2.ZERO
	if old_position.distance_to(target_position) > 16:
		target_position += _target.idle_input_vector * -16
		if old_position.distance_to(target_position) > 4:
			path_direction = (target_position - old_position).normalized()

	_character.move(delta, path_direction)


func set_target(value: Character) -> void:
	_target = value
	set_physics_process(_target != null)
