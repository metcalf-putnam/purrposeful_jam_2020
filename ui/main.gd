extends Node


func _ready():
	Music.start("menu")


func _on_Button_pressed():
	get_tree().change_scene("res://root.tscn")
