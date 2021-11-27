extends Node

const TILE_SIZE: int = 16
const PoisonTrapRes := preload("res://items/poison_trap.tscn")
const Character := preload("res://characters/character.gd")
const Inventory := preload("res://ui/inventory.gd")

var _current_action_node: Node = null

onready var _action_box := get_node("../ActionBox") as Area2D
onready var _character := get_parent() as Character
onready var _inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func _trigger_place_item() -> void:
	if _inventory.get_item_count(2) <= 0:
		return

	var new_item_pos := _character.snapped_position + _action_box.position

	# Check if new position is not colliding with anything
	var space_state := _character.get_world_2d().direct_space_state
	var result := space_state.intersect_ray(_character.position, new_item_pos)
	if !result:
		var item := PoisonTrapRes.instance()
		item.position = new_item_pos
		_character.get_parent().add_child(item)
		_inventory.increment_item_count(2, -1)


func trigger_action() -> void:
	if _current_action_node:
		_current_action_node.call_deferred("trigger_action")
	else:
		_trigger_place_item()


func set_action_box_position(position: Vector2) -> void:
	_action_box.position = position


func _on_ActionBox_body_entered(body: Node):
	var action_node := body.get_node_or_null("Action") as Node
	if action_node:
		if _current_action_node:
			_current_action_node.set_button_hint(false)
		_current_action_node = action_node
		_current_action_node.show_button_hint()


func _on_ActionBox_body_exited(body: Node):
	var action_node := body.get_node_or_null("Action") as Node
	if _current_action_node == action_node:
		_current_action_node.set_button_hint(false)
		_current_action_node = null
