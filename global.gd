extends Node

var player_can_throw = true
var mouse_on_bird = false

var level = 1
var level_data = {
	1: {
		"goal": 6, 
		"time_limit": 85,
		"lasso_speed": PI,
		"dog_array": [10],
		"kitten_prob_density": [1],
		"min_time": 3,
		"max_time": 4
	},
		2: {
		"goal": 6, 
		"time_limit": 80,
		"lasso_speed": PI*1.1,
		"dog_array": [5, 25, 49],
		"kitten_prob_density": [1],
		"min_time": 2.5,
		"max_time": 4
	},
		3: {
		"goal": 8, 
		"time_limit": 90,
		"lasso_speed": PI*1.2,
		"dog_array": [2, 18, 27, 38, 62],
		"kitten_prob_density": [0.8, 1],
		"min_time": 1.5,
		"max_time": 3.5
	},
		4: {
		"goal": 8, 
		"time_limit": 80,
		"lasso_speed": PI*1.3,
		"dog_array": [9, 29, 42, 58, 76],
		"kitten_prob_density": [.4, 0.8, 1],
		"min_time": 1,
		"max_time": 3
	},
		5: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.5,
		"dog_array": [2, 9, 25, 38, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.3, .7, 1],
		"min_time": 1,
		"max_time": 2.5
	},
		6: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.6,
		"dog_array": [2, 9, 25, 38, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.2, .6, 1],
		"min_time": 1,
		"max_time": 2.5
	},
		7: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.7,
		"dog_array": [1, 7, 18, 25, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.2, .5, 1],
		"min_time": 1,
		"max_time": 2.5
	},
		8: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.5,
		"dog_array": [3, 11, 25, 38, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.1, .4, 1],
		"min_time": 1,
		"max_time": 2.5
	},
		9: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.5,
		"dog_array": [0, 15, 25, 38, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.1, .3, 1],
		"min_time": 1,
		"max_time": 2.5
	},
		10: {
		"goal": 10, 
		"time_limit": 90,
		"lasso_speed": PI*1.5,
		"dog_array": [2, 9, 25, 38, 40, 60, 68, 77, 85],
		"kitten_prob_density": [.1, .2, 1],
		"min_time": 1,
		"max_time": 2.5
	}
}
