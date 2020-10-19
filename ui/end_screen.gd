extends CanvasLayer
const failure_message = "So close!"
const level_prefix = "Level "
var level_suffix = " of " + str(Global.level_data.size())
var last_level = false


func _ready():
	$ColorRect/Level.text = level_prefix + str(Global.level) + level_suffix
	if !Global.level_data.has(Global.level+1):
		last_level = true
		$ColorRect/HBoxContainer/Next.change_text("end")


func init(score, goal):
	if score >= goal:
		$ColorRect/HBoxContainer/Next.visible = true
		$Success.play()
	else:
		$ColorRect/Message.text = failure_message
		$ColorRect/HBoxContainer/Next.visible = false
		$Failure.play()


func _on_Restart_pressed():
	Transition.reload_current()


func _on_Next_pressed():
	if last_level:
		# TODO: put ending scene here instead
		Transition.set_and_play_new_scene("res://ui/main.tscn")
	else:
		Global.level += 1
		Transition.reload_current()

