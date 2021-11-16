extends Area2D


func _on_Item_body_entered(body):
	var health_system = body.get_node_or_null("../HealthSystem")
	if health_system:
		health_system.take_damage(100)

	queue_free()
