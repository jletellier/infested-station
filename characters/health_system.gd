extends Node

export var health = 100


func take_damage(strength: int, origin_position = null):
    health -= strength

    if origin_position:
        var character = get_node("../Character")
        var delta_vector = character.position - origin_position
        delta_vector = delta_vector.normalized()
        character.position += delta_vector * 8
        character.snapped_position = Vector2.ZERO

    if (health <= 0):
        get_parent().queue_free()
