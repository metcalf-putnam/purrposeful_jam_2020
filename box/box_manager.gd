extends Node2D
var goal


func _ready():
	EventHub.connect("kitten_caught", self, "_on_kitten_caught")
	EventHub.connect("puppy_borked", self, "_on_puppy_bork")
	goal = Global.level_data[Global.level]["goal"]
	initialize_boxes()


func initialize_boxes():
	var count = 0
	for child in get_children():
		if count >= goal:
			child.visible = false
		count += 1


func _on_kitten_caught(kitten_in):
	for child in get_children():
		if !child.has_kitten() and child.visible:
			child.add_kitten(kitten_in)
			return


func _on_puppy_bork():
	for child in get_children():
		if child.has_kitten():
			child.spook_kitten()
			EventHub.emit_signal("kitten_spooked")
			return
