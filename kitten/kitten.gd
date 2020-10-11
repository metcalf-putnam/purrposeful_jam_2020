extends Area2D
var caught = false


func _on_Kitten_body_entered(body):
	if caught:
		return
	if body.is_in_group("lasso"):
		caught = true
		get_lassoed()
		body.lasso(self)


func get_lassoed():
	$Sprite.texture = load("res://prog_art/lassoed_kitten.png")
	$Mew.play()


func _on_VisibilityNotifier2D_screen_exited():
	if caught:
		return
	queue_free()


func _on_Mew_finished():
	EventHub.emit_signal("kitten_capture_complete")
