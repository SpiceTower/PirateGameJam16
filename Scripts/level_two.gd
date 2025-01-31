extends Node

@export var detector: Detector
@export var total_bricks = 15
@export var total_generators = 2

@onready var dialog_box: RichTextLabel = $CanvasLayer/Control/DialogBox

var tween
var text_duration = 0.0

signal brick_destroyed
signal talk_trigger
signal button_press
signal generator_destroyed

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.button_press.connect(end_level_button)
	detector.generator_destroyed.connect(generators_remaining)
	dialog_box.visible_ratio = 0.0

func bricks_remaining():
	total_bricks = total_bricks - 1
	if total_bricks == 10:
		if BackgroundProcess.get_rebel_one() == false:
			dialog_box.text = "I can just see those glorious profits now!"
		else:
			dialog_box.text = "You should make peace with destruction!"
		yap()
		#detector.talk_trigger.emit("lvl 2 30%")
	if total_bricks == 5:
		if BackgroundProcess.get_rebel_one() == false:
			dialog_box.text = "More bang, more buck, har har har!"
		else:
			dialog_box.text = "See? I told them you weren’t a complete failure, har har har!"
		yap()
		#detector.talk_trigger.emit("lvl 2 60%")
	if total_bricks == 0:
		end_level_bricks()

func generators_remaining():
	total_generators = total_generators -1
#	print(total_generators)
	if total_generators == 1:
		if BackgroundProcess.get_rebel_one() == false:
			dialog_box.text = "System failure? But how?"
		else:
			dialog_box.text = "A generator? Down!? Impossible!"
		yap()
		#detector.talk_trigger.emit("lvl two 1st generator destroyed")
	if total_generators == 0:
		if BackgroundProcess.get_rebel_one() == false:
			dialog_box.text = "Don’t do this! Think of the profits!"
		else:
			dialog_box.text = "By all that is lucrative… You wouldn’t…"
		yap()
		#detector.talk_trigger.emit("lvl two 2nd generator destroyed")

func end_level_button():
	dialog_box.text = "You’ve made a grave mistake, and a terrible enemy this day. B.411, you FOOL!"
	yap()
	BackgroundProcess.second_rebel()
	end_level()
	#detector.talk_trigger.emit("lvl two button")
	
func end_level_bricks():
	false_victory()
	#detector.talk_trigger.emit("lvl two bricks")
	
func yap():
	text_duration = dialog_box.text.length() / 30.0
	$YapTimer.wait_time = text_duration + 5.0
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

func end_level():
	$EndLevel.start()
	$B411.ball_speed = 0
	$CanvasLayer/Curtains.show()
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("fade")
	
func false_victory():
	$FalseVictory.start()
	$B411.ball_speed = 0
	$CanvasLayer/Curtains.show()
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("fade")

func _on_end_level_timeout():
	get_tree().change_scene_to_file("res://Scenes/debriefLevel3.tscn")

func _on_false_victory_timeout():
	get_tree().change_scene_to_file("res://Scenes/false_victory.tscn")
