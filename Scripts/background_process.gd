extends Node2D


var lives = 0
var rebel1 = false
var rebel2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset_bgp():
	lives = 1
	rebel1 = false
	rebel2 = false

func first_rebel():
	rebel1 = true
	extra_life()

func get_rebel_one():
	return rebel1

func second_rebel():
	rebel2 = true
	extra_life()

func get_rebel_two():
	return rebel2

func extra_life():
	lives += 1

func get_lives():
	return lives
