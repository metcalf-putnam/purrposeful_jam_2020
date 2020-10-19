extends Node2D
var path_prefix = "res://close_scene/end8f"
var path_suffix = ".png"
var frame = 1
var last_frame = 6


func _ready():
	get_tree().paused = false
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
	Music.start("menu")
	yield(get_tree().create_timer(1.8), "timeout")
	$AudioStreamPlayer.play()


func _on_Timer_timeout():
	frame += 1
	if frame > last_frame:
		$Timer.stop()
		$Purr.play()
	else:
		load_new_frame()


func load_new_frame():
	var path = path_prefix + str(frame) + path_suffix
	$Sprite.texture = load(path)


func _on_Purr_finished():
	yield(get_tree().create_timer(1.8), "timeout")
	Transition.set_and_play_new_scene("res://ui/main.tscn")
	Music.stop()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)
