extends Node

export var health = 100

func take_damage(strength: int):
    health -= strength

    if (health <= 0):
        get_parent().queue_free()
