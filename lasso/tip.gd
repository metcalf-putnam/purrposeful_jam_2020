extends KinematicBody2D
signal caught_kitten
var free_to_grab = true


func lasso(kitten : Area2D):
	if !free_to_grab:
		return
	free_to_grab = false
	emit_signal("caught_kitten", kitten)	
	kitten.get_parent().call_deferred("remove_child", kitten)
	call_deferred("add_child", kitten)
	kitten.position = $Loop.position

