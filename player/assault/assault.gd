extends "res://player/player.gd"

func _ready():
	speed = 10

func double_jump():
	if has_double_jumped == false:
		fall.y = jump
		has_double_jumped = true
