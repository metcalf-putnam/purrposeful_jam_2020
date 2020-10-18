extends Position2D
var puppy


func _ready():
	EventHub.connect("puppy_caught", self, "_on_puppy_caught")
	EventHub.connect("kitten_ready_for_box", self, "_on_ready_for_box")


func _on_puppy_caught(puppy_in):
	puppy = puppy_in


func _on_ready_for_box(ready_puppy):
	if ready_puppy == puppy:
		print("let's go!!")
		puppy.get_parent().call_deferred("remove_child", puppy)
		call_deferred("add_child", puppy)
		puppy.be_boxed()
