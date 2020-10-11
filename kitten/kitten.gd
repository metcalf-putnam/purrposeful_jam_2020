extends Area2D
var caught = false


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
