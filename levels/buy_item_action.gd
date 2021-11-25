extends Node

const Inventory := preload("res://ui/inventory.gd")

onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func trigger_action():
	if _inventory.get_item_count(1) > 0:
		_inventory.increment_item_count(1, -1)
		_inventory.increment_item_count(2, 1)
