extends Node

const Door := preload("res://levels/door.gd")
const Inventory := preload("res://ui/inventory.gd")

onready var _door := get_parent() as Door
onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func trigger_action():
	if _inventory.get_item_count(0) > 0:
		_inventory.increment_item_count(0, -1)
		_door.update_open(true)
