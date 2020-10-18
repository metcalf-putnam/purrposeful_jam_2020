extends Kitten


func get_borked():
	visible = true
	$AnimationPlayer.play("bork")
	EventHub.emit_signal("puppy_borked")


func disappear():
	$AnimationPlayer.play("poof_away")


func _on_poofed_away():
	queue_free()
