extends Node

const Character := preload("res://characters/character.gd")

export var health: int = 100

onready var character := get_parent() as Character


func take_damage(strength: int, origin_position := Vector2()) -> void:
    health -= strength

    if origin_position:
        var delta_vector: Vector2 = character.position - origin_position
        delta_vector = delta_vector.normalized()
        character.position += delta_vector * 8
        character.snapped_position = Vector2.ZERO

    if (health <= 0):
        character.queue_free()
