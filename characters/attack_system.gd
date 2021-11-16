extends Node

export var strength = 100


func _on_HitBox_body_entered(body: Node):
	var health_system = body.get_node_or_null("../HealthSystem")
	if health_system:
		health_system.take_damage(strength)
