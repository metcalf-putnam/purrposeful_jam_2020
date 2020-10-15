extends KinematicBody2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and !Global.mouse_on_bird:
			$Lasso.shoot()


func _on_Lasso_kitten_detained(kitten):
	# TODO: check if kitten is actually a puppy
	if kitten.is_in_group("puppies"):
		_on_puppy_caught()
	else:
		EventHub.emit_signal("increment_kittens")
	kitten.be_detained()


func _on_puppy_caught():
	pass
