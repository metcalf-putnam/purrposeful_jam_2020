extends Node2D
var songs = []
enum State {SINGING, IDLE, READY}
var state = State.IDLE
var rng = RandomNumberGenerator.new()
var can_sing = false


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
	state = State.SINGING
	$AnimationPlayer.play("sing")
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
		$AnimationPlayer.play("idle")
		get_tree().call_group("kittens", "walk")


func _on_CooldownTimer_timeout():
	can_sing = true
	$AnimationPlayer.play("ready")


func _on_SongTimer_timeout():
	state = State.IDLE


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and can_sing:
			sing()
