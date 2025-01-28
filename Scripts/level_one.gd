extends Node

@export var detector: Detector
@export var total_bricks = 15

signal brick_destroyed
signal talk_trigger
signal button_press

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.button_press.connect(end_level_button)

func bricks_remaining():
	total_bricks = total_bricks - 1
	print(total_bricks)
	if total_bricks == 10:
		detector.talk_trigger.emit("lvl 1 30%")
	if total_bricks == 5:
		detector.talk_trigger.emit("lvl 1 60%")
	if total_bricks == 0:
		end_level_bricks()

func end_level_button():
	detector.talk_trigger.emit("lvl one button")
	
func end_level_bricks():
	detector.talk_trigger.emit("lvl one bricks")
