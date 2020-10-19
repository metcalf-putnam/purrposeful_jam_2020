extends Node


func _ready():
	get_tree().paused = false
	Music.start("menu")
	Global.level = 1


func _on_Button_pressed():
	Music.stop()
	Transition.set_and_play_new_scene("res://root.tscn")
