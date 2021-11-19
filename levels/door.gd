extends StaticBody2D

export var open: bool = false

onready var door_sprite := $DoorSprite as AnimatedSprite
onready var collision_shape := $CollisionShape2D as CollisionShape2D


func _ready() -> void:
	_update_open()


func _update_open() -> void:
	if open:
		door_sprite.animation = "open"
		collision_shape.disabled = true
	else:
		door_sprite.animation = "close"
		collision_shape.disabled = false


func _on_InsideArea_body_entered(_body: Node) -> void:
	pass


func _on_OutsideArea_body_entered(_body: Node) -> void:
	pass


func _on_OutsideArea_body_exited(_body: Node) -> void:
	pass
