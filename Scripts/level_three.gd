extends Node

@export var detector: Detector
@export var total_bricks = 19
@export var total_generators = 2

signal brick_destroyed
signal talk_trigger
signal boss_death
signal evil_throw

var evil_balls_thrown = 0

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.boss_death.connect(win_the_game)
	detector.evil_throw.connect(evil_ball)

func bricks_remaining():
	total_bricks = total_bricks - 1
	print(total_bricks)
	if total_bricks == 12:
		detector.talk_trigger.emit("lvl 3 30%")
	if total_bricks == 6:
		detector.talk_trigger.emit("lvl 3 60%")
	if total_bricks == 0:
		end_level_bricks()

func end_level_bricks():
	detector.talk_trigger.emit("lvl three bricks")
	
func win_the_game():
	detector.talk_trigger.emit("Win The Game")

func evil_ball():
	evil_balls_thrown = evil_balls_thrown + 1
	if evil_balls_thrown == 1:
		detector.talk_trigger.emit("first evil ball")
	if evil_balls_thrown == 4:
		detector.talk_trigger.emit("evil ball thrown")
		evil_balls_thrown = 1
