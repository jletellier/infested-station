extends Node

enum {
	MOVE,
	PLACE,
}

const TILE_SIZE: int = 16
const ItemRes := preload("res://items/item.tscn")
const Character := preload("res://characters/character.gd")
const Inventory := preload("res://ui/inventory.gd")

var state := MOVE

onready var character := get_parent() as Character
onready var inventory := $"/root/MainScene/HUD/Inventory" as Inventory


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			_move_state(delta)
		PLACE:
			_place_state()


func _move_state(delta: float) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if !input_vector:
		if Input.is_action_just_pressed("ui_accept"):
			state = PLACE

	character.move(delta, input_vector)


func _place_state() -> void:
	state = MOVE

	var item_count = inventory.get_item_count(0)
	if (item_count == 0):
		return

	var new_item_pos = character.snapped_position + (
			(character.animation_tree.get("parameters/idle/blend_position") * TILE_SIZE)
	)

	# Check if new position is not colliding with anything
	var space_state := character.get_world_2d().direct_space_state
	var result := space_state.intersect_ray(character.position, new_item_pos)
	if !result:
		var item = ItemRes.instance()
		item.position = new_item_pos
		character.get_parent().add_child(item)
		inventory.set_item_count(0, item_count - 1)
