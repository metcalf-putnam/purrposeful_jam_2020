extends Area2D
class_name Kitten

var entered = false
var caught = false
var capture_complete = false
var direction
var speed = 50.0
enum State {WALKING, LISTENING, IDLE}
var state = State.IDLE
var meows = []



func _ready():
	set_process(false)


func init_meow(meow : AudioStream):
	$Enter.stream = meow


func init_speed(speed_in : float):
	speed = speed_in


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
	$Caught.play()
	$AnimationPlayer.play("caught")


func spook():
	$AnimationPlayer.play("spook")


func be_boxed():
	visible = true
	$AnimationPlayer.play("appear")


func _on_VisibilityNotifier2D_screen_exited():
	if caught or !entered:
		return
	queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	entered = true
	$Enter.play()
	if Music.bird_song:
		listen()


func be_detained():
	capture_complete = true
	visible = false
	$AnimationPlayer.play("disappear")


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


func on_spook_end():
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "caught":
		EventHub.emit_signal("kitten_capture_complete")
	if anim_name == "disappear":
		EventHub.emit_signal("kitten_ready_for_box", self)
	if anim_name == "appear":
		$AnimationPlayer.play("box_idle")
		if !is_in_group("puppies"):
			EventHub.emit_signal("increment_kittens")
