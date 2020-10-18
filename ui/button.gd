extends Button
signal pressed_sound_finished


func _on_Button_mouse_entered():
	$Hover.play()


func _on_Button_pressed():
	$Select.play()


func _on_Select_finished():
	emit_signal("pressed_sound_finished")
