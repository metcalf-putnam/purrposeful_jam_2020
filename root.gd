extends Node2D
export (PackedScene) var EndScreen
var end_screen_open = false


func _ready():
	$CanvasLayer/LevelLabel.text = "Level " + str(Global.level)
	EventHub.connect("restart_level", self, "_on_restart_level")
	get_tree().paused = false
	Music.start()


func _on_TimeMeter_time_out():
	if end_screen_open:
		return
	end_level()


func end_level():
	print("time left: ", $CanvasLayer/TimeLabel/TimeMeter.time)
	end_screen_open = true
	get_tree().paused = true
	Music.bird_song = false
	Music.stop()
	$AnimationPlayer.play("fade_to_black")
	var end_screen = EndScreen.instance()
	end_screen.init($CanvasLayer/Count.kitten_count, $CanvasLayer/Count.goal, $CanvasLayer/TimeLabel/TimeMeter.time)
	add_child(end_screen)


func _on_restart_level():
	get_tree().reload_current_scene()


func _on_Count_goal_achieved():
	end_level()
