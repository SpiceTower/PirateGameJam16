extends Node

@export var detector: Detector
@export var total_bricks = 15
@export var total_generators = 2

signal brick_destroyed
signal talk_trigger
signal button_press
signal generator_destroyed

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.button_press.connect(end_level_button)
	detector.generator_destroyed.connect(generators_remaining)

func bricks_remaining():
	total_bricks = total_bricks - 1
	if total_bricks == 10:
		detector.talk_trigger.emit("lvl 2 30%")
	if total_bricks == 5:
		detector.talk_trigger.emit("lvl 2 60%")
	if total_bricks == 0:
		end_level_bricks()

func generators_remaining():
	total_generators = total_generators -1
#	print(total_generators)
	if total_generators == 1:
		detector.talk_trigger.emit("lvl two 1st generator destroyed")
	if total_generators == 0:
		detector.talk_trigger.emit("lvl two 2nd generator destroyed")

func end_level_button():
	detector.talk_trigger.emit("lvl two button")
	
func end_level_bricks():
	detector.talk_trigger.emit("lvl two bricks")
