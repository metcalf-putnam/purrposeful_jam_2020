extends Node2D

onready var rope = $Rope		# A slightly easier reference to the links
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip := Vector2(0,0)			
var buffer_length := 15.0

const SPEED = 10	# The speed with which the chain moves

enum State{FLYING, HOOKED, INACTIVE, RETRACTING}
var state = State.INACTIVE

var lassoed_kitten 
var viewport

signal kitten_detained


func _ready():
	viewport = get_viewport_rect().size

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	if state != State.INACTIVE:
		return	
	$Tip/Loop.visible = true
	state = State.FLYING				
	tip = self.global_position
	direction = dir.normalized()

# release() the chain
func release() -> void:
	state = State.INACTIVE


# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	if state == State.INACTIVE:
		self.visible = false
		$Tip/Loop.visible = true # reset so visible next time we shoot
		return
	self.visible = true
	if tip.x >= viewport.x - buffer_length or tip.x <= buffer_length:
		state = State.RETRACTING
	if tip.y >= viewport.y - buffer_length or tip.y <= buffer_length:
		state = State.RETRACTING
	var tip_loc = to_local(tip)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	rope.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	rope.position = tip_loc
	rope.region_rect.size.y = tip_loc.length()	
	if tip_loc.length() < buffer_length and state != State.FLYING:
		if state == State.HOOKED:
			emit_signal("kitten_detained", lassoed_kitten)
			lassoed_kitten = null
		release()


func _physics_process(_delta: float) -> void:
	$Tip.global_position = tip	# The player might have moved and thus updated the position of the tip -> reset it
	match state:
		State.FLYING:
		# `if move_and_collide()` always moves, but returns true if we did collide
			$Tip.move_and_collide(direction * SPEED)
		State.HOOKED:
			$Tip.move_and_collide(-direction * SPEED)
		State.RETRACTING:
			$Tip.move_and_collide(-direction * SPEED)
			
	tip = $Tip.global_position	# set `tip` as starting position for next frame


func _on_Tip_caught_kitten(kitten):
	lassoed_kitten = kitten
	state = State.HOOKED
	$Tip/Loop.visible = false
