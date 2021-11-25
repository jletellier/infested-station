extends KinematicBody2D

const TILE_SIZE: int = 16

export var acceleration: int = 325
export var max_speed: int = 60

var velocity := Vector2.ZERO
var snapped_position := Vector2.ZERO
var idle_input_vector := Vector2.ZERO

onready var animation_player := $AnimationPlayer as AnimationPlayer
onready var animation_tree := $AnimationTree as AnimationTree
onready var animation_state := (
		animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
)


func _ready() -> void:
	animation_tree.active = true


func move(delta: float, input_vector := Vector2.ZERO) -> void:
	if input_vector != Vector2.ZERO:
		idle_input_vector = input_vector
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/walk/blend_position", input_vector)
		animation_state.travel("walk")
		snapped_position = Vector2.ZERO
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		if snapped_position == Vector2.ZERO:
			snapped_position = (
					position -
					(Vector2.ONE * TILE_SIZE / 2) +
					(idle_input_vector * TILE_SIZE / 2)
			)
			snapped_position = snapped_position.snapped(Vector2.ONE * TILE_SIZE)
			snapped_position += Vector2.ONE * TILE_SIZE / 2

		animation_state.travel("idle")
		position = position.move_toward(snapped_position, max_speed * delta)
		velocity = Vector2.ZERO

	velocity = move_and_slide(velocity)
