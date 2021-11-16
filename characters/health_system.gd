extends Node

export var health = 100

func take_damage():
    health -= 100

    if (health <= 0):
        get_parent().queue_free()
