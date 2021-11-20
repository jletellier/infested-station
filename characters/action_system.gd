extends Node
# This is an extremely simple (and ugly) action system that definitely needs refinement

const TILE_SIZE: int = 16
const PoisonTrapRes := preload("res://items/poison_trap.tscn")
const Character := preload("res://characters/character.gd")
const Inventory := preload("res://ui/inventory.gd")

var _current_action_node: Node = null
var _current_item_idx: int = 2

onready var character := get_parent() as Character
onready var inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func _trigger_place_item() -> void:
	var new_item_pos = character.snapped_position + (
			(character.animation_tree.get("parameters/idle/blend_position") * TILE_SIZE)
	)

	# Check if new position is not colliding with anything
	var space_state := character.get_world_2d().direct_space_state
	var result := space_state.intersect_ray(character.position, new_item_pos)
	if !result:
		var item = PoisonTrapRes.instance()
		item.position = new_item_pos
		character.get_parent().add_child(item)
		_use_item()


func _can_use_item() -> bool:
	var item_count = inventory.get_item_count(_current_item_idx)
	return (item_count > 0)


func _use_item() -> void:
	inventory.increment_item_count(_current_item_idx, -1)


func set_action_node(node: Node, item_idx: int) -> void:
	_current_action_node = node
	_current_item_idx = item_idx

func unset_action_node(node: Node) -> void:
	if _current_action_node == node:
		_current_action_node = null
		_current_item_idx = 2


func trigger_action() -> void:
	if _can_use_item():
		if _current_action_node:
			_current_action_node.call_deferred("trigger_action")
			_use_item()
		else:
			_trigger_place_item()
