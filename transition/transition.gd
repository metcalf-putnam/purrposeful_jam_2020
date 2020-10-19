extends CanvasLayer
enum State {IDLE, CHANGING}
var state = State.IDLE
var new_scene


func reload_current():
	new_scene = "current"
	fade_out()


func set_and_play_new_scene(scene_in : String):
	new_scene = scene_in
	fade_out()


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"black":
			$AnimationPlayer.play("fade_in")
		"fade_in":
			pass
		"fade_to_black":
			change_scene()


func fade_out():
	$AnimationPlayer.play("fade_to_black")
	# TODO: music as well?


func fade_in():
	$AnimationPlayer.play("fade_in")
	# TODO: music change as well?
	

func change_scene():
	if new_scene == "current":
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene(new_scene)
	fade_in()
