extends Node2D

export var open: bool = false

onready var door_sprite := $DoorSprite as AnimatedSprite


func _ready() -> void:
	_update_open()


func _update_open() -> void:
	if open:
		door_sprite.z_index = 0
		door_sprite.animation = "open"
	else:
		door_sprite.z_index = 1
		door_sprite.animation = "close"


func _on_InsideArea_body_entered(_body: Node) -> void:
	pass


func _on_OutsideArea_body_entered(_body: Node) -> void:
	open = true
	_update_open()


func _on_OutsideArea_body_exited(_body: Node) -> void:
	open = false
	_update_open()
