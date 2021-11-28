extends Area2D

const ParticleRes := preload("res://items/poison_trap_particles.tscn")
const HealthSystem := preload("res://characters/health_system.gd")


func _on_Item_body_entered(body: Node) -> void:
	var health_system := body.get_node_or_null("HealthSystem") as HealthSystem
	if health_system:
		health_system.take_damage(100)

	var particle := ParticleRes.instance() as CPUParticles2D
	particle.position = position
	particle.emitting = true
	get_parent().add_child(particle)

	queue_free()
