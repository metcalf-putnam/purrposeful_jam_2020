extends Node


func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	$MainLoop.play()
