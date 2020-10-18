extends Node
var bird_song = false
var main_db
var menu_db


func _ready():
	main_db = $MainLoop.volume_db
	menu_db = $MenuLoop.volume_db


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
	
