extends Node


func _ready():
	Music.start("menu")


func _on_Button_pressed():
	Music.stop()


func _on_Button_pressed_sound_finished():
	Transition.set_and_play_new_scene("res://root.tscn")
