extends Node2D
var kitten


func _ready():
	EventHub.connect("kitten_ready_for_box", self, "_on_kitten_ready_for_box")


func add_kitten(kitten_in):
	kitten = kitten_in


func _on_kitten_ready_for_box(ready_kitten):
	if ready_kitten == kitten:
		kitten.get_parent().call_deferred("remove_child", kitten)
		$KittenHolder.call_deferred("add_child", kitten)
		kitten.be_boxed()


func spook_kitten():
	if kitten:
		kitten.spook()
		kitten = null


func has_kitten() -> bool:
	if kitten:
		return true
	else:
		return false
