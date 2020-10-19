extends TextureButton
signal pressed_sound_finished
export var text : String
var normal_color = Color(.48, .33, .36)
var hover_color = Color(.59, .52, .54)
var pressed_color = Color(.88, .23, .15)


func change_text(text_in):
	text = text_in
	$Label.text = text


func _ready():
	$Label.text = text
	$Label.set("custom_colors/font_color", normal_color)


func _on_Button_mouse_entered():
	$Hover.play()
	$Label.set("custom_colors/font_color", hover_color)


func _on_Button_pressed():
	$Select.play()
	$Label.set("custom_colors/font_color", pressed_color)


func _on_Select_finished():
	emit_signal("pressed_sound_finished")


func _on_Button_mouse_exited():
	$Label.set("custom_colors/font_color", normal_color)


func _on_Button_button_up():
	$Label.set("custom_colors/font_color", hover_color)
