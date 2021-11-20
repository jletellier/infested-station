extends Node

const Door := preload("res://levels/door.gd")
const ActionSystem := preload("res://characters/action_system.gd")

onready var _door := get_parent() as Door


func _on_OutsideArea_body_exited(body: Node):
	var action_system := body.get_node_or_null("ActionSystem") as ActionSystem
	if action_system:
		action_system.unset_action_node(self)


func _on_OutsideArea_body_entered(body: Node):
	var action_system := body.get_node_or_null("ActionSystem") as ActionSystem
	if action_system:
		action_system.set_action_node(self, 0)


func trigger_action():
	_door.update_open(true)
