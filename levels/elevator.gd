extends Node2D

export var open = false

onready var door_sprite = $DoorSprite


func _ready():
	update_open()


func _on_InsideArea_body_entered(_body: Node):
	pass


func _on_OutsideArea_body_entered(_body: Node):
	open = true
	update_open()


func _on_OutsideArea_body_exited(_body: Node):
	open = false
	update_open()


func update_open():
	if open:
		door_sprite.z_index = 0
		door_sprite.animation = "open"
	else:
		door_sprite.z_index = 1
		door_sprite.animation = "close"
