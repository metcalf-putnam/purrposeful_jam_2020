extends KinematicBody2D
var direction = "center"


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and !Global.mouse_on_bird:
			$Body/LassoHolder/Lasso.shoot()


func _on_Lasso_kitten_detained(kitten):
	# TODO: check if kitten is actually a puppy
	if kitten.is_in_group("puppies"):
		EventHub.emit_signal("puppy_caught", kitten)
	else:
		EventHub.emit_signal("kitten_caught", kitten)
	kitten.be_detained()
	$AnimationPlayer.play("idle")


func _on_Lasso_retracting():
	if direction == "left":
		$AnimationPlayer.play("pull_left")
	else:
		$AnimationPlayer.play("pull_right")


func _on_Lasso_throwing():
	if direction == "left":
		$AnimationPlayer.play("throw_right")
	else:
		$AnimationPlayer.play("throw_right")


func _on_Lasso_spinning():
	$AnimationPlayer.play("idle")


func _on_Lasso_lasso_direction_changed(new_direction):
	direction = new_direction
	match new_direction:
		"center":
			$Arm.frame = 12
			$Body/LassoHolder.position = $Body/LassoPositions/Center.position
		"left":
			$Arm.frame = 13
			$Body/LassoHolder.position = $Body/LassoPositions/Left.position
		"right":
			$Arm.frame = 14
			$Body/LassoHolder.position = $Body/LassoPositions/Right.position
