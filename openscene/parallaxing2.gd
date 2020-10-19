extends Sprite


var t = 0.0
var t_max = 36.0
var x_start = 460.0
var x_end = 1200#1460.0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	t += delta
	
	self.position.x = x_start + (x_end - x_start)*(t/t_max)
	
	#print_debug(t)
	
	pass
