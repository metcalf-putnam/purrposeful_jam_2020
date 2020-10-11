extends Area2D
var caught = false
var capture_complete = false


func _on_Kitten_body_entered(body):
	if caught:
		return
	if body.is_in_group("lasso"):
		caught = true
		get_lassoed()
		body.lasso(self)


func get_lassoed():
	$Sprite.texture = load("res://prog_art/lassoed_kitten.png")
	$Mew.play()
	$AnimationPlayer.play("caught")


func _on_VisibilityNotifier2D_screen_exited():
	if caught:
		return
	queue_free()


func _on_Mew_finished():
	if capture_complete:
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "caught":
		EventHub.emit_signal("kitten_capture_complete")


func be_detained():
	capture_complete = true
	# Makes invisible if capture mew still playing
	visible = false  # TODO: reparent kitten so is bouncing around main character
	if $Mew.is_playing():
		return
	queue_free()
