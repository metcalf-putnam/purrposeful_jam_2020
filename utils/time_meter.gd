extends ProgressBar
export var max_time : int
var time 
signal time_out


func _ready():
	time = max_time
	max_value = time


func _on_Timer_timeout():
	time -= .25
	value = time
	
	if time <= 0:
		emit_signal("time_out")
		$Timer.stop()
