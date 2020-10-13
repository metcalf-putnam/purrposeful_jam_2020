extends Node2D
export (PackedScene) var EndScreen



func _ready():
	EventHub.connect("restart_level", self, "_on_restart_level")
	get_tree().paused = false


func _on_TimeMeter_time_out():
	get_tree().paused = true
	var end_screen = EndScreen.instance()
	end_screen.init($CanvasLayer/Count.kitten_count, $CanvasLayer/Count.goal)
	add_child(end_screen)


func _on_restart_level():
	get_tree().reload_current_scene()
	
