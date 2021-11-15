# This was initially heavily based on
# https://github.com/uheartbeast/youtube-tutorials/blob/master/Action%20RPG/Player/Player.gd

extends KinematicBody2D

export var ACCELERATION = 325
export var MAX_SPEED = 60
export var FRICTION = 1000

enum {
	MOVE,
	PLACE,
}

const ItemRes = preload("res://items/item.tscn")
const TILE_SIZE = 16

var state = MOVE
var velocity = Vector2.ZERO
var snapped_position = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	randomize()
	animation_tree.active = true


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

	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/walk/blend_position", input_vector)
		animation_state.travel("walk")
		snapped_position = Vector2.ZERO
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if snapped_position == Vector2.ZERO:
			snapped_position = (
				position - 
				(Vector2.ONE * TILE_SIZE / 2) +
				(animation_tree.get("parameters/idle/blend_position") * TILE_SIZE / 2))
			snapped_position = snapped_position.snapped(Vector2.ONE * TILE_SIZE)
			snapped_position += Vector2.ONE * TILE_SIZE / 2
		
		animation_state.travel("idle")
		position = position.move_toward(snapped_position, MAX_SPEED * delta)
		velocity = Vector2.ZERO
		# velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

		if Input.is_action_just_pressed("ui_accept"):
			state = PLACE

	velocity = move_and_slide(velocity)


func place_state():
	state = MOVE

	var new_item_pos = (
		snapped_position + (animation_tree.get("parameters/idle/blend_position") * TILE_SIZE))

	# Check if new position is not colliding with anything
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, new_item_pos)
	if !result:
		var item = ItemRes.instance()
		item.position = new_item_pos
		self.get_parent().add_child(item)
