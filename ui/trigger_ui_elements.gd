extends Node

const Inventory := preload("res://ui/inventory.gd")

onready var _cutscene_player := $"/root/MainScene/HUD/CutsceneRect/AnimationPlayer" as AnimationPlayer
onready var _curtain_player := $"/root/MainScene/HUD/CurtainRect/AnimationPlayer" as AnimationPlayer
onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func set_cutscene_mode(is_enabled: bool) -> void:
	if is_enabled:
		_cutscene_player.current_animation = "Show"
		_inventory.visible = false
	else:
		_cutscene_player.current_animation = "Hide"
		_inventory.visible = true


func set_curtain_mode(is_enabled: bool) -> void:
	if is_enabled:
		_curtain_player.current_animation = "Show"
	else:
		_curtain_player.current_animation = "Hide"
