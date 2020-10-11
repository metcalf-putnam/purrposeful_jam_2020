extends KinematicBody2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			$Lasso.shoot(event.position - global_position)


func _on_Lasso_kitten_detained(_kitten):
	EventHub.emit_signal("increment_kittens")
	_kitten.queue_free()
