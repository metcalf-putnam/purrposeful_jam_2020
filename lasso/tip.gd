extends KinematicBody2D
signal kitten_detected


func lasso(kitten : Area2D):
	emit_signal("kitten_detected", kitten)

