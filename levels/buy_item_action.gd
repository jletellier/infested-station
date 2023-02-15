extends Node

const Inventory := preload("res://ui/inventory.gd")

@onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory
@onready var _button_hint := $"ButtonHint" as Sprite2D


func trigger_action() -> void:
	if can_trigger_action():
		_inventory.increment_item_count(1, -1)
		_inventory.increment_item_count(2, 1)
		show_button_hint()


func can_trigger_action() -> bool:
	return (_inventory.get_item_count(1) > 0)


func show_button_hint() -> void:
	_button_hint.visible = can_trigger_action()


func set_button_hint(is_visible: bool) -> void:
	_button_hint.visible = is_visible
