extends Node2D
var songs = []
enum State {SINGING, IDLE, READY}
var state = State.IDLE
var rng = RandomNumberGenerator.new()
var can_sing = false
var selected_modulate = Color(0.4, 0.68, 0.19)
var normal_modulate = Color(1, 1, 1)


func _ready():
	Global.mouse_on_bird = false
	rng.randomize()
	$CooldownTimer.start()


func sing():
	can_sing = false
	state = State.SINGING
	update_sprite()
	$AudioStreamPlayer.play()
	Music.bird_song = true
	get_tree().call_group("kittens", "listen")


func _on_AudioStreamPlayer_finished():
	state = State.IDLE
	Music.bird_song = false
	update_sprite()
	get_tree().call_group("kittens", "walk")
	$CooldownTimer.start()


func _on_CooldownTimer_timeout():
	can_sing = true
	state = State.READY
	update_sprite()


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and can_sing:
			print("bird sing")
			get_tree().set_input_as_handled()
			sing()


func _on_Area2D_mouse_entered():
	Global.mouse_on_bird = true
	update_sprite()


func _on_Area2D_mouse_exited():
	Global.mouse_on_bird = false
	update_sprite()
		

func update_sprite():
	match state:
		State.IDLE:
			$AnimationPlayer.play("idle")
			modulate = normal_modulate
			$Area2D/Sprite.visible = false
		State.READY:
			if Global.mouse_on_bird:
				modulate = selected_modulate
				$Area2D/Sprite.visible = false
			else:
				modulate = normal_modulate
				$Area2D/Sprite.visible = true
			$AnimationPlayer.play("ready")
		State.SINGING:
			$AnimationPlayer.play("sing")
			modulate = normal_modulate
			$Area2D/Sprite.visible = false
	
