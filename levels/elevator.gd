extends Node2D

var is_open = false

onready var door_sprite = $DoorSprite


func _on_InsideArea_body_entered(_body: Node):
	door_sprite.z_index = 1
	door_sprite.animation = "close"


func _on_OutsideArea_body_entered(_body: Node):
    door_sprite.z_index = 0
    door_sprite.animation = "open"
