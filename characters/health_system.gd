extends Node

const Character := preload("res://characters/character.gd")
const TriggerUIElements := preload("res://ui/trigger_ui_elements.gd")

export var health: int = 100

var _is_dead: bool = false

onready var character := get_parent() as Character
onready var trigger_ui_elements = get_node("../../../TriggerUIElements") as TriggerUIElements


func take_damage(strength: int, origin_position := Vector2()) -> void:
	if _is_dead:
		return

	if origin_position:
		var delta_vector: Vector2 = character.position - origin_position
		delta_vector = delta_vector.normalized()
		character.position += delta_vector * 4
		character.snapped_position = Vector2.ZERO
		character.move(0, Vector2.ZERO)

	health -= strength
	character.animation_tree.set("parameters/hurt/blend_position", character.idle_input_vector)
	character.animation_state.travel("hurt")

	if (health <= 0):
		_is_dead = true
		var control := character.get_node_or_null("CharacterControl") as Node
		if control:
			control.set_physics_process(false)
			trigger_ui_elements.set_curtain_mode(true)
		else:
			character.queue_free()
