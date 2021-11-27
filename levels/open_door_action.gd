extends Node

const Door := preload("res://levels/door.gd")
const Inventory := preload("res://ui/inventory.gd")

onready var _door := get_parent() as Door
onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory
onready var _button_hint := $"ButtonHint" as Sprite


func trigger_action():
	if can_trigger_action():
		_inventory.increment_item_count(0, -1)
		_door.update_open(true)
		show_button_hint()


func can_trigger_action() -> bool:
	return (_inventory.get_item_count(0) > 0)


func show_button_hint() -> void:
	_button_hint.visible = can_trigger_action()


func set_button_hint(is_visible: bool) -> void:
	_button_hint.visible = is_visible
