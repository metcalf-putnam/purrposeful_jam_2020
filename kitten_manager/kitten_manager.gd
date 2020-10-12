extends Node2D
var rng = RandomNumberGenerator.new()
export (PackedScene) var Kitten
export var right_walking = true
var random_limit = 200

func _ready():
	spawn_kitten()
	rng.randomize()


func _on_Timer_timeout():
	spawn_kitten()


func spawn_kitten():
	print("spawning!")
	var kitten = Kitten.instance()
	$Spawn.add_child(kitten)
	kitten.position += Vector2(0, rng.randf_range(-random_limit, random_limit))
	if right_walking:
		kitten.walk(Vector2(1, 0))
	else:
		kitten.walk(Vector2(-1, 0))
		kitten.scale.x = -1
