extends Label

const label_prefix = "Kittens: "
var kitten_count :=0 
export var goal := 20


func _ready():
	EventHub.connect("increment_kittens", self, "_on_increment_kittens")
	update_label()


func update_label():
	text = label_prefix + str(kitten_count)


func _on_increment_kittens():
	kitten_count += 1
	update_label()



