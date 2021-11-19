extends Area2D

const HealthSystem := preload("res://characters/health_system.gd")


func _on_Item_body_entered(body: Node) -> void:
	var health_system := body.get_node_or_null("HealthSystem") as HealthSystem
	if health_system:
		health_system.take_damage(100)

	queue_free()
