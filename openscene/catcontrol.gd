extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0.0
var t_max = 36.0
var cat = 1
#var x_start = 170.0
#var x_end = 1250.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.modulate.a = 0.0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+=delta
	if t>3.0 and t<7.0:
		
		self.modulate.a=(t-3.0)/4.0
		
		pass
	
	if t>10.0 and t<12:
		
		self.modulate.a=1-(t-10.0)/2.0
		
		pass
	
	if t>12.0 and t <24.0 and cat == 1 :
		
		
		self.texture = load("res://openscene/pngs/paracat2.png")
		#self.position.x = get_parent().get_node("closer").position.x -100 #+500
		
		self.modulate.a = 0.0
		
		cat = 2
	
	if t>14.0 and t<18.0:
		
		self.position.x = get_parent().get_node("closer").position.x -100 #+500
		self.modulate.a=(t-14.0)/4.0
	
	if t>18.0 and t<22.0:
		self.modulate.a = 1.0
		self.position.x = get_parent().get_node("closer").position.x -100
		
	
	if t>22.0 and t<24.00:
		
		self.position.x = get_parent().get_node("closer").position.x -100
		self.modulate.a=1-(t-22.0)/2.0
		
	
	if t>24.0 and t <36.0 and cat == 2 :
		
		
		self.texture = load("res://openscene/pngs/paracat3.png")
		#self.position.x = get_parent().get_node("closer").position.x -100 #+500
		
		self.modulate.a = 0.0
		
		cat = 3
	
	if t>26.0 and t<30.0:
		
		self.position.x = get_parent().get_node("distant").position.x -100 #+500
		self.modulate.a=(t-26.0)/4.0
	
	if t>30.0 and t<34.0:
		self.modulate.a = 1.0
		self.position.x = get_parent().get_node("distant").position.x -100
		
	
	if t>34.0 and t<36.00:
		
		self.position.x = get_parent().get_node("distant").position.x -100
		self.modulate.a=1-(t-34.0)/2.0
	
	pass
