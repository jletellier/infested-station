extends CharacterBody2D

const TILE_SIZE: int = 16
const TILE_HALF_SIZE: int = int(TILE_SIZE / 2.0)

@export var acceleration: int = 325
@export var max_speed: int = 60

var idle_input_vector := Vector2.ZERO
var last_input_vector := Vector2.ZERO
var snapped_position := Vector2.ZERO
var is_snapping_x := false
var is_snapping_y := false

@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var animation_tree := $AnimationTree as AnimationTree
@onready var animation_state := (
		animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
)


func _ready() -> void:
	animation_tree.active = true


func move(delta: float, input_vector := Vector2.ZERO) -> void:
	if input_vector.x != 0:
		last_input_vector.x = input_vector.x
		is_snapping_x = false
	if input_vector.y != 0:
		last_input_vector.y = input_vector.y
		is_snapping_y = false

	if input_vector.x == 0 && !is_snapping_x:
		is_snapping_x = true
		snapped_position.x = _snap_float(position.x, round(last_input_vector.x))
	if input_vector.y == 0 && !is_snapping_y:
		is_snapping_y = true
		snapped_position.y = _snap_float(position.y, round(last_input_vector.y))

	if is_snapping_x:
		var snapping_distance := snapped_position.x - position.x
		if abs(snapping_distance) < 1:
			position.x = snapped_position.x
		else:
			input_vector.x = sign(snapping_distance)
	if is_snapping_y:
		var snapping_distance := snapped_position.y - position.y
		if abs(snapping_distance) < 1:
			position.y = snapped_position.y
		else:
			input_vector.y = sign(snapping_distance)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		idle_input_vector = input_vector
		animation_tree.set("parameters/walk/blend_position", input_vector)
		animation_state.travel("walk")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animation_tree.set("parameters/idle/blend_position", idle_input_vector)
		animation_state.travel("idle")
		velocity = Vector2.ZERO

	move_and_slide()

	if is_snapping_x && abs(velocity.x) < acceleration * delta:
		snapped_position.x = _snap_float(position.x)

	if is_snapping_y && abs(velocity.y) < acceleration * delta:
		snapped_position.y = _snap_float(position.y)


func _snap_float(value: float, direction: float = 0) -> float:
	var result := value - TILE_HALF_SIZE
	result += direction * TILE_HALF_SIZE
	result = round(result / TILE_SIZE) * TILE_SIZE + TILE_HALF_SIZE
	return result
