extends Node2D
export (PackedScene) var EndScreen
var end_screen = false


func _ready():
	EventHub.connect("restart_level", self, "_on_restart_level")
	get_tree().paused = false
	Music.start()


func _on_TimeMeter_time_out():
	if end_screen:
		return
	end_level()


func end_level():
	end_screen = true
	get_tree().paused = true
	Music.bird_song = false
	Music.stop()
	$AnimationPlayer.play("fade_to_black")
	var end_screen = EndScreen.instance()
	end_screen.init($CanvasLayer/Count.kitten_count, $CanvasLayer/Count.goal)
	add_child(end_screen)


func _on_restart_level():
	get_tree().reload_current_scene()


func _on_Count_goal_achieved():
	end_level()
