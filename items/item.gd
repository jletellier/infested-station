extends Area2D

const Inventory := preload("res://ui/inventory.gd")

export var _item_idx: int = 0

onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func _on_Item_body_entered(_body: Node):
	_inventory.increment_item_count(_item_idx, 1)

	queue_free()
