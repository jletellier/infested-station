extends Node

enum {
	MOVE,
	PLACE,
}

const ItemRes = preload("res://items/item.tscn")
const TILE_SIZE = 16

var state = MOVE

onready var character = $"../Character"


func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		PLACE:
			place_state()

			
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector == Vector2.ZERO:
		if Input.is_action_just_pressed("ui_accept"):
			state = PLACE

	character.move(delta, input_vector)


func place_state():
	state = MOVE

	var new_item_pos = character.snapped_position + (
		(character.animation_tree.get("parameters/idle/blend_position") * TILE_SIZE))

	# Check if new position is not colliding with anything
	var space_state = character.get_world_2d().direct_space_state
	var result = space_state.intersect_ray(character.position, new_item_pos)
	if !result:
		var item = ItemRes.instance()
		item.position = new_item_pos
		self.get_parent().get_parent().add_child(item)
