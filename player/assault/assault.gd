extends "res://player/player.gd"

var blink_dist = 10

func _ready():
	speed = 10

func dash():
	if Input.is_action_just_pressed("ability"):
		translate(direction * blink_dist)
