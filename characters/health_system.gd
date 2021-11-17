extends Node

export var health = 100

onready var character = get_parent()


func take_damage(strength: int, origin_position = null):
    health -= strength

    if origin_position:
        var delta_vector = character.position - origin_position
        delta_vector = delta_vector.normalized()
        character.position += delta_vector * 8
        character.snapped_position = Vector2.ZERO

    if (health <= 0):
        character.queue_free()
