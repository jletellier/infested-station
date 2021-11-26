extends Node

const FollowCharacter := preload("res://characters/follow_character.gd")
const Character := preload("res://characters/character.gd")

export var is_active: bool = true

onready var _player := $"../../Player" as Character
onready var _follow_character := $"../FollowCharacter" as FollowCharacter


func trigger_action() -> void:
	if is_active:
		_follow_character.set_target(_player)


func set_is_active(value: bool) -> void:
	is_active = value
