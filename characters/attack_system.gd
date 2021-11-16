extends Node

export var strength = 100
export var cooldown = 1

var target_health_system = null
var last_hit_delta = cooldown

onready var character = $"../Character"


func _on_HitBox_body_entered(body: Node):
	var health_system = body.get_node_or_null("../HealthSystem")
	if health_system:
		target_health_system = health_system


func _on_HitBox_body_exited(body: Node):
	var health_system = body.get_node_or_null("../HealthSystem")
	if health_system == target_health_system:
		target_health_system = null


func _physics_process(delta):
	if target_health_system:
		if last_hit_delta > cooldown:
			var origin_position = character.position
			target_health_system.take_damage(strength, origin_position)
			last_hit_delta = 0

	last_hit_delta += delta
