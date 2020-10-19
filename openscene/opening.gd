extends Node2D


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
	Music.start("menu")
	yield(get_tree().create_timer(2.5), "timeout")
	$AudioStreamPlayer.play()


func _on_AudioStreamPlayer_finished():
	yield(get_tree().create_timer(1), "timeout")
	Music.stop()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)
	Transition.set_and_play_new_scene("res://root.tscn")
