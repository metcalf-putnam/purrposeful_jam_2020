extends CanvasLayer
const victory_message = "Success!"
const failure_message = "So close!"



func init(score, goal):
	if score >= goal:
		$ColorRect/Label.text = victory_message
		$ColorRect/HBoxContainer/Next.visible = true
		$Success.play()
	else:
		$ColorRect/Label.text = failure_message
		$ColorRect/HBoxContainer/Next.visible = false
		$Failure.play()


func _on_Restart_pressed_sound_finished():
	EventHub.emit_signal("restart_level")


func _on_Next_pressed_sound_finished():
	pass 
