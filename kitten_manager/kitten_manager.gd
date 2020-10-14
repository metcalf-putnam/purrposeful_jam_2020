extends Node2D
var rng = RandomNumberGenerator.new()
export (PackedScene) var Kitten
export (PackedScene) var Puppy
export var right_walking = true
var random_limit = 135
var meows = []
var min_time = 1.5
var max_time = 3.5
var time_spent = 0
var puppy_index = 0
var puppy_array = [2, 22, 42, 55]


func _ready():
	load_meows()
	spawn_kitten(true)
	rng.randomize()


func load_meows():
	var prefix := "res://kitten/sounds/mews"
	var suffix := ".wav"
	for i in range(1, 10):
		if i == 4:
			continue # this is the caught one for now
		var meow = prefix + str(i) + suffix
		meows.append(load(meow))


func _on_Timer_timeout():
	if puppy_index < len(puppy_array) and puppy_array[puppy_index] <= time_spent:
		spawn_kitten(false)
		puppy_index += 1
	else:
		spawn_kitten(true)
	var wait_time = rng.randf_range(min_time, max_time)
	$Timer.start(wait_time)
	time_spent += wait_time


func spawn_kitten(kitty_bool):
	var right_bool = rng.randi_range(0, 1)
	var kitten
	if kitty_bool:
		kitten = get_random_kitten()
		kitten.init_meow(meows[rng.randi_range(0, len(meows) - 1)])
	else:
		kitten = Puppy.instance()
	if right_bool:
		$RightSpawn.add_child(kitten)
		kitten.walk(Vector2(-1, 0))
		kitten.scale.x = -1
	else:
		$LeftSpawn.add_child(kitten)
		kitten.walk(Vector2(1, 0))
	kitten.position += Vector2(0, rng.randf_range(-random_limit, random_limit))

func get_random_kitten():
	# TODO: when get different kitten types, pick one according to probability distribution
	return Kitten.instance()
