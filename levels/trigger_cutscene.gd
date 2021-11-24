extends Node

const Inventory := preload("res://ui/inventory.gd")

onready var player := $"/root/MainScene/HUD/CutsceneRect/AnimationPlayer" as AnimationPlayer
onready var inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func set_cutscene_mode(is_enabled: bool) -> void:
	if is_enabled:
		player.current_animation = "Show"
		inventory.visible = false
	else:
		player.current_animation = "Hide"
		inventory.visible = true
