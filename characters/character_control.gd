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
onready var level_node := $"../../../" as Node
onready var level_player := level_node.get_node("AnimationPlayer") as AnimationPlayer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_reload"):
		var _reload_code := level_node.get_tree().reload_current_scene()

	if (!is_physics_processing() &&
		Input.is_action_just_pressed("ui_cancel") &&
		level_player.current_animation != "WeDidIt" &&
		level_player.current_animation_position > 1 &&
		level_player.current_animation_position < level_player.current_animation_length - 2
	):
		level_player.seek(level_player.current_animation_length - 2)


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

	action_system.set_action_box_position(character.idle_input_vector * TILE_SIZE)

	if !input_vector:
		if Input.is_action_just_pressed("ui_accept"):
			state = ACTION

	character.move(delta, input_vector)


func _action_state() -> void:
	action_system.trigger_action()
	state = MOVE
