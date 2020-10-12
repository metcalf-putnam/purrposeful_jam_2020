extends Area2D
var entered = false
var caught = false
var capture_complete = false
var direction
var speed = 50
enum State {WALKING, LISTENING, IDLE}
var state = State.IDLE


func _ready():
	set_process(false)


func _on_Kitten_body_entered(body):
	if caught:
		return
	if body.is_in_group("lasso"):
		body.lasso(self)


func walk(direction_in := direction):
	if caught:
		return
	state = State.WALKING
	set_process(true)
	direction = direction_in.normalized()
	$AnimationPlayer.play("walk")


func get_lassoed():
	caught = true
	$Sprite.texture = load("res://prog_art/lassoed_kitten.png")
	$Mew.play()
	$AnimationPlayer.play("caught")


func _on_VisibilityNotifier2D_screen_exited():
	if caught or !entered:
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


func _on_VisibilityNotifier2D_screen_entered():
	entered = true


func _process(delta):
	if caught:
		set_process(false)
		return
	var velocity = direction * speed
	position += velocity * delta


func listen():
	if caught:
		return
	state = State.LISTENING
	set_process(false)
	$AnimationPlayer.play("idle")
