extends Area2D


func _on_Item_body_entered(_body):
	queue_free()
