extends KinematicBody2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			$Lasso.shoot()


func _on_Lasso_kitten_detained(kitten):
	EventHub.emit_signal("increment_kittens")
	kitten.be_detained()
