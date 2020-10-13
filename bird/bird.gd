extends Node2D
var songs = []
enum State {SINGING, IDLE, READY}
var state = State.IDLE
var rng = RandomNumberGenerator.new()
var can_sing = false
var selected_modulate = Color(0.4, 0.68, 0.19)
var normal_modulate = Color(1, 1, 1)
var mouse_in_range = false


func _ready():
	rng.randomize()
	load_songs()
	$CooldownTimer.start()


func load_songs():
	var prefix := "res://bird/Bird"
	var suffix := ".wav"
	
	for i in range(1, 5):
		var song_path = prefix + str(i) + suffix
		var song = load(song_path)
		songs.append(song)


func sing():
	can_sing = false
	state = State.SINGING
	update_sprite()
	$CooldownTimer.start()
	$SongTimer.start()
	play_song_file()


func play_song_file():
	var song = songs[rng.randi_range(0, len(songs) - 1)]
	$AudioStreamPlayer.stream = song
	$AudioStreamPlayer.play()
	get_tree().call_group("kittens", "listen")


func _on_AudioStreamPlayer_finished():
	if state == State.SINGING:
		play_song_file()
	else:
		state = State.IDLE
		update_sprite()
		get_tree().call_group("kittens", "walk")


func _on_CooldownTimer_timeout():
	can_sing = true
	state = State.READY
	update_sprite()


func _on_SongTimer_timeout():
	state = State.IDLE


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and can_sing:
			get_tree().set_input_as_handled()
			sing()


func _on_Area2D_mouse_entered():
	mouse_in_range = true
	update_sprite()


func _on_Area2D_mouse_exited():
	mouse_in_range = false
	update_sprite()
		

func update_sprite():
	match state:
		State.IDLE:
			$AnimationPlayer.play("idle")
			modulate = normal_modulate
			$Area2D/Sprite.visible = false
		State.READY:
			if mouse_in_range:
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
	
