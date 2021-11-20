extends Node

enum {
	MOVE,
	ACTION,
}

const TILE_SIZE: int = 16
const Character := preload("res://characters/character.gd")
const ActionSystem := preload("res://characters/action_system.gd")

var state := MOVE

onready var character := get_parent() as Character
onready var action_system := $"../ActionSystem" as ActionSystem


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			_move_state(delta)
		ACTION:
			_action_state()


func _move_state(delta: float) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if !input_vector:
		if Input.is_action_just_pressed("ui_accept"):
			state = ACTION

	character.move(delta, input_vector)


func _action_state() -> void:
	action_system.trigger_action()
	state = MOVE
