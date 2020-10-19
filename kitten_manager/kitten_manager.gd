extends Node2D

export (PackedScene) var OrangeKitten
export (PackedScene) var BlackKitten
export (PackedScene) var SocksKitten
export (PackedScene) var Puppy

# spawn time and location vars
var random_limit = 135
var min_time = 1.5
var max_time = 3.5
var min_speed = .9
var max_speed = 1.2

# cat-related vars
var meows = []
var kitten_prob_density = []

# puppy-related vars
var time_spent = 0
var puppy_index = 0
var puppy_array = [2, 22, 42, 55]

var rng = RandomNumberGenerator.new()


func _ready():
	load_meows()
	load_level_data()
	spawn_kitten(true)
	rng.randomize()


func load_level_data():
	var data = Global.level_data[Global.level]
	puppy_array = data["dog_array"]
	min_time = data["min_time"]
	max_time = data["max_time"]
	kitten_prob_density = data["kitten_prob_density"]


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
		
	add_child(kitten)
	if right_bool:
		kitten.position = $RightSpawn.position
		kitten.walk(Vector2(-1, 0))
		kitten.scale.x = -1
	else:
		kitten.position = $LeftSpawn.position
		kitten.walk(Vector2(1, 0))

	kitten.position += Vector2(0, rng.randf_range(-random_limit, random_limit))
	kitten.init_speed(rng.randf_range(min_speed, max_speed))


func get_random_kitten():
	print("kitten prob density: ", kitten_prob_density)
	var prob = rng.randf_range(0, 1.0)
	print("prob: ", prob)
	if !kitten_prob_density:
		return OrangeKitten.instance()
		
	if kitten_prob_density.size() >= 1 and prob <= kitten_prob_density[0]:
		return OrangeKitten.instance()
	if kitten_prob_density.size() >= 2 and prob <= kitten_prob_density[1]: 
		return SocksKitten.instance()
	if kitten_prob_density.size() >= 3 and prob <= kitten_prob_density[2]:
		return BlackKitten.instance()
	
	return OrangeKitten.instance()
	
