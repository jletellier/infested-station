extends Node

const FollowCharacter := preload("res://characters/follow_character.gd")
const Character := preload("res://characters/character.gd")

export var is_active: bool = true

onready var _player := $"../../Player" as Character
onready var _follow_character := $"../FollowCharacter" as FollowCharacter
onready var _button_hint := $"ButtonHint" as Sprite


func trigger_action() -> void:
	if can_trigger_action():
		_follow_character.set_target(_player)
		is_active = false
		show_button_hint()


func can_trigger_action() -> bool:
	return is_active


func show_button_hint() -> void:
	_button_hint.visible = can_trigger_action()


func set_button_hint(is_visible: bool) -> void:
	_button_hint.visible = is_visible


func set_is_active(value: bool) -> void:
	is_active = value
