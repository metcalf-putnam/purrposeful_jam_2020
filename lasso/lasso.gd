extends Node2D

onready var rope = $Rope		# A slightly easier reference to the links
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip := Vector2(0,0)			
var buffer_length := 5
var spinning_offset = 30
export var rotation_speed = PI*5/4

const SPEED = 14	# The speed with which the lasso moves
const RETRACTION_ADJUSTMENT = 0.75 # Slower coming back

enum State{FLYING, HOOKED, INACTIVE, RETRACTING, SPINNING}
var state = State.INACTIVE

var lassoed_kitten 
var viewport
var screen_direction = "center"


signal kitten_detained
signal retracting
signal throwing
signal spinning
signal lasso_direction_changed


func _ready():
	spin()
	viewport = get_viewport_rect().size
	EventHub.connect("kitten_capture_complete", self, "_on_kitten_capture_complete")
	var data = Global.level_data[Global.level]
	rotation_speed = data["lasso_speed"]

# shoot() shoots the chain in a given direction
func shoot() -> void:
	if state != State.SPINNING:
		return
#	if rotation_degrees < 182 or rotation_degrees > 358:
#		return
	emit_signal("throwing")
	$Throw.play()
	$Tip/Loop.visible = true
	state = State.FLYING
	direction = Vector2(cos(rotation), sin(rotation))


func spin():
	state = State.SPINNING
	emit_signal("spinning")
	$Tip/Loop.visible = true


func release() -> void:
	state = State.INACTIVE


func is_in_bounds() -> bool:
	if tip.y >= viewport.y - buffer_length or tip.y <= buffer_length:
		return false
	if tip.x >= viewport.x - buffer_length or tip.x <= buffer_length:
		return false
	return true

# Every graphics frame we update the visuals
func _process(delta: float) -> void:
	var tip_loc
	
	match state:
		State.INACTIVE:
			self.visible = false
			return
		State.FLYING:
			if !is_in_bounds():
				state = State.RETRACTING
				emit_signal("retracting")
				$Miss.play()
		State.RETRACTING:
			tip_loc = to_local(tip)
			if tip_loc.length() < spinning_offset:
				if lassoed_kitten:
					emit_signal("kitten_detained", lassoed_kitten)
					lassoed_kitten = null
				spin()
		State.SPINNING:
			rotation += rotation_speed * delta
			rotation = fmod(rotation, 2 * PI)
			var angle_buffer = 2
			if rotation_degrees >= 180 - angle_buffer and rotation_degrees < 180 + angle_buffer:
				$Swing.play()
			get_direction()
	
	# Draw the rope connected to the loop
	self.visible = true
	tip_loc = to_local(tip)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	rope.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	rope.position = tip_loc
	rope.region_rect.size.y = tip_loc.length()	


func _physics_process(_delta: float) -> void:
	#$Tip.global_position = tip	# The player might have moved and thus updated the position of the tip -> reset it
	match state:
		State.SPINNING:
			$Tip.position.x = spinning_offset
			$Tip.position.y = 0
		State.FLYING:
		# `if move_and_collide()` always moves, but returns true if we did collide
			$Tip.move_and_collide(direction * SPEED)
		State.RETRACTING:
			$Tip.move_and_collide(-direction * SPEED * RETRACTION_ADJUSTMENT)
			
	tip = $Tip.global_position	# set `tip` as starting position for next frame


func _on_kitten_capture_complete():
	state = State.RETRACTING
	emit_signal("retracting")
	$Pull.play()


func _on_Tip_kitten_detected(kitten):
	if state != State.FLYING and state != State.RETRACTING:
		return
	if lassoed_kitten:
		return
	kitten.get_parent().call_deferred("remove_child", kitten)
	$Tip.call_deferred("add_child", kitten)
	kitten.get_lassoed()
	kitten.position = $Tip/Loop.position
	lassoed_kitten = kitten
	state = State.HOOKED
	$Tip/Loop.visible = false


func get_direction():
	var new_direction
	if rotation_degrees >= 45 and rotation_degrees < 135:
		new_direction = "center"
	elif rotation_degrees >= 135 and rotation_degrees < 225:
		new_direction = "left"
	elif rotation_degrees >= 225 and rotation_degrees < 315:
		new_direction = "center"
	else:
		new_direction = "right"
	
	if new_direction != screen_direction:
		emit_signal("lasso_direction_changed", new_direction)
		
	screen_direction = new_direction
