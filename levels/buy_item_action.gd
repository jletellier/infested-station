extends Node

const ActionSystem := preload("res://characters/action_system.gd")
const Inventory := preload("res://ui/inventory.gd")

onready var inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func _on_ActionArea_body_exited(body: Node):
	var action_system := body.get_node_or_null("ActionSystem") as ActionSystem
	if action_system:
		action_system.unset_action_node(self)


func _on_ActionArea_body_entered(body: Node):
	var action_system := body.get_node_or_null("ActionSystem") as ActionSystem
	if action_system:
		action_system.set_action_node(self, 1)


func trigger_action():
	inventory.increment_item_count(2, 1)
