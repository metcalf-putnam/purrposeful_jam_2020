extends Label

const label_prefix = "Kittens: "
var kitten_count := 0 
var goal := 5

signal goal_achieved

func _ready():
	goal = Global.level_data[Global.level]["goal"]
	EventHub.connect("increment_kittens", self, "_on_increment_kittens")
	EventHub.connect("kitten_spooked", self, "_on_decrement_kittens")
	update_label()



func update_label():
	text = label_prefix + str(kitten_count) + "/" + str(goal)


func _on_increment_kittens():
	kitten_count += 1
	update_label()
	if kitten_count >= goal:
		emit_signal("goal_achieved")


func _on_decrement_kittens():
	kitten_count -= 1
	update_label()



