extends Node

@export var detector: Detector
@export var total_bricks = 15

@onready var dialog_box: RichTextLabel = $CanvasLayer/Control/DialogBox

var glass_health = 2
var tween
var text_duration = 0.0

signal brick_destroyed
signal talk_trigger
signal button_press
signal button_glass

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.button_press.connect(end_level_button)
	detector.button_glass.connect(glass_break)
	dialog_box.visible_ratio = 0.0

func bricks_remaining():
	total_bricks = total_bricks - 1
	print(total_bricks)
	if total_bricks == 10:
		dialog_box.text = "I can almost smell that freedom already!"
		yap()
		#detector.talk_trigger.emit("lvl 1 30%")
	if total_bricks == 5:
		dialog_box.text = "Wow, you’re on fire! Better not come near me, har har har!"
		yap()
		#detector.talk_trigger.emit("lvl 1 60%")
	if total_bricks == 0:
		end_level_bricks()

func end_level_button():
	dialog_box.text = "No, that’s not supposed to- AAAAAHHHHH!!!"
	yap()
	#detector.talk_trigger.emit("lvl one button")
	
func end_level_bricks():
	pass
	#detector.talk_trigger.emit("lvl one bricks")

func glass_break():
	glass_health = glass_health -1 
	if glass_health == 1:
		dialog_box.text = "Is that the sound of them cracking under the pressure?"
		yap()
		#detector.talk_trigger.emit("lvl one crack glass")
	if glass_health == 0:
		dialog_box.text = "I love the sound of broken glass and dreams in the- wait a minute…"
		yap()
		#detector.talk_trigger.emit("lvl one break glass")

func yap():
	text_duration = dialog_box.text.length() / 30.0
	$"Talking Boss".start_talk()
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(dialog_box, "visible_ratio", 1.0, text_duration)
	tween.finished
	$YapTimer.start()

func _on_yap_timer_timeout():
	dialog_box.visible_ratio = 0.0
	$"Talking Boss".stop_talk()
