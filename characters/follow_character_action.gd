extends Node

const FollowCharacter := preload("res://characters/follow_character.gd")
const Character := preload("res://characters/character.gd")

onready var _player := $"../../Player" as Character
onready var _follow_character := $"../FollowCharacter" as FollowCharacter


func trigger_action():
	_follow_character.set_target(_player)
