extends StaticBody2D

export var _open: bool = false

onready var door_sprite := $DoorSprite as AnimatedSprite
onready var collision_shape := $CollisionShape2D as CollisionShape2D


func _ready() -> void:
	update_open(_open)


func update_open(open: bool) -> void:
	_open = open
	if open:
		door_sprite.animation = "open"
		collision_shape.call_deferred("set", "disabled", true);
	else:
		door_sprite.animation = "close"
		collision_shape.call_deferred("set", "disabled", false);
