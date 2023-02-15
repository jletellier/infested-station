extends Node

const Character := preload("res://characters/character.gd")
const HealthSystem := preload("res://characters/health_system.gd")

@export var strength: int = 100
@export var cooldown: float = 0.5

var target_health_system: HealthSystem = null
var last_hit_delta: float = cooldown

@onready var character := get_parent() as Character


func _physics_process(delta: float) -> void:
	if target_health_system:
		if last_hit_delta > cooldown:
			var origin_position := character.position
			target_health_system.take_damage(strength, origin_position)
			last_hit_delta = 0

	last_hit_delta += delta


func _on_HitBox_body_entered(body: Node) -> void:
	var health_system := body.get_node_or_null("HealthSystem") as HealthSystem
	if health_system:
		target_health_system = health_system


func _on_HitBox_body_exited(body: Node) -> void:
	var health_system := body.get_node_or_null("HealthSystem") as HealthSystem
	if health_system == target_health_system:
		target_health_system = null
