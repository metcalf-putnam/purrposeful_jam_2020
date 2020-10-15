extends Node
var bird_song = false


func start(type = "level"):
	if type == "menu":
		$MainLoop.stop()
		$MenuLoop.play()
	else:
		$MenuLoop.stop()
		$MainLoop.play()


func stop():
	$MainLoop.stop()
	$MenuLoop.stop()
	
