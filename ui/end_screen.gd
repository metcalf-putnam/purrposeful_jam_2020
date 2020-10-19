extends CanvasLayer
const failure_message = "So close!"
const level_prefix = "Level "
var level_suffix = " of " + str(Global.level_data.size())
var last_level = false
var time_left

func _ready():
	$ColorRect/Level.text = level_prefix + str(Global.level) + level_suffix
	if !Global.level_data.has(Global.level+1):
		last_level = true
		$ColorRect/HBoxContainer/Next.change_text("end")


func init(score, goal, time):
	time_left = time
	if score >= goal:
		$ColorRect/Message.visible = false
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
		Transition.set_and_play_new_scene("res://close_scene/ending.tscn")
	else:
		Global.level += 1
		Transition.reload_current()


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == "three_star":
		$Purr.play()


func _on_Success_finished():
	if time_left >= 18:
		$AnimationPlayer.play("three_star")
		return
	if time_left >= 7:
		$AnimationPlayer.play("two_star")
		return
	$AnimationPlayer.play("one_star")

