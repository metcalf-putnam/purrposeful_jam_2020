extends Node

signal restart_level

# once kitten capture animation has finished and can pull back in
signal kitten_capture_complete

# once kitten or puppy has been fully caught and can be poofed to next place
signal kitten_caught
signal puppy_caught

# kitten has poofed out, ready to be added to box
signal kitten_ready_for_box


signal puppy_borked
signal kitten_spooked


signal increment_kittens
