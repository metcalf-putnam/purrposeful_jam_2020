extends Kitten
var speed_multiplier = 1.01

func _ready():
	speed = 30
	$AnimationPlayer.playback_speed = .5


func _process(delta):
	speed = speed * speed_multiplier
	$AnimationPlayer.playback_speed = $AnimationPlayer.playback_speed * speed_multiplier
