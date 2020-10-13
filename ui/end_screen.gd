extends CanvasLayer
const victory_message = "Success!"
const failure_message = "So close!"


func init(score, goal):
	if score >= goal:
		$ColorRect/Label.text = victory_message
		$Success.play()
	else:
		$ColorRect/Label.text = failure_message
		$Failure.play()


func _on_Button_pressed():
	EventHub.emit_signal("restart_level")
