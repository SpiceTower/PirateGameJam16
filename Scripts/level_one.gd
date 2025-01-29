extends Node

@export var detector: Detector
@export var total_bricks = 15

var glass_health = 2

signal brick_destroyed
signal talk_trigger
signal button_press
signal button_glass

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.button_press.connect(end_level_button)
	detector.button_glass.connect(glass_break)

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

func glass_break():
	glass_health = glass_health -1 
	if glass_health == 1:
		detector.talk_trigger.emit("lvl one crack glass")
	if glass_health == 0:
		detector.talk_trigger.emit("lvl one break glass")
