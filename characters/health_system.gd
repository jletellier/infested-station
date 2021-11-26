extends Node

const Character := preload("res://characters/character.gd")
const TriggerUIElements := preload("res://ui/trigger_ui_elements.gd")

export var health: int = 100

onready var character := get_parent() as Character
onready var trigger_ui_elements = get_node("../../../TriggerUIElements") as TriggerUIElements


func take_damage(strength: int, origin_position := Vector2()) -> void:
	health -= strength

	if origin_position:
		var delta_vector: Vector2 = character.position - origin_position
		delta_vector = delta_vector.normalized()
		character.position += delta_vector * 8
		character.snapped_position = Vector2.ZERO

	if (health <= 0):
		var control := character.get_node_or_null("CharacterControl") as Node
		if control:
			control.set_physics_process(false)
			trigger_ui_elements.set_curtain_mode(true)
		else:
			character.queue_free()
