extends Node


func _ready():
	yield(get_tree().create_timer(0.5), "timeout")


func start():
	$MainLoop.play()


func stop():
	$MainLoop.stop()
