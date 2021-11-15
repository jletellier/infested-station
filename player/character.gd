extends KinematicBody2D

export var ACCELERATION = 325
export var MAX_SPEED = 60

const TILE_SIZE = 16

var velocity = Vector2.ZERO
var snapped_position = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	animation_tree.active = true
		

func move(delta, input_vector = Vector2.ZERO):
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

	velocity = move_and_slide(velocity)
