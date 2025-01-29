extends Node

@export var detector: Detector
@export var total_bricks = 19
@export var total_generators = 2

@onready var dialog_box: RichTextLabel = $CanvasLayer/Control/DialogBox

signal brick_destroyed
signal talk_trigger
signal boss_death
signal evil_throw

var evil_balls_thrown = 0
var tween
var text_duration = 0.0

func _ready() -> void:
	detector.brick_destroyed.connect(bricks_remaining)
	detector.boss_death.connect(win_the_game)
	detector.evil_throw.connect(evil_ball)
	dialog_box.visible_ratio = 0.0

func bricks_remaining():
	total_bricks = total_bricks - 1
	print(total_bricks)
	if total_bricks == 12:
		dialog_box.text = "Those precious bricks of yours? Your final lifeline!"
		yap()
		#detector.talk_trigger.emit("lvl 3 30%")
	if total_bricks == 6:
		dialog_box.text = "These shades? So I never have to look away from all the explosions, har har har!"
		yap()
		#detector.talk_trigger.emit("lvl 3 60%")
	if total_bricks == 0:
		end_level_bricks()

func end_level_bricks():
	dialog_box.text = "You penniless fools thought this advanced program and special B411 title meant something? Your arrogance and belief in a ‘greater good’ are your downfall. Be awed by the brilliance of my grand victory!"
	yap()
	#detector.talk_trigger.emit("lvl three bricks")
	
func win_the_game():
	dialog_box.text = "I can’t believe it! Your idealism doesn’t generate profit. Your compassion doesn’t bring new investors. How? How could this happen? UGHHHH."
	yap()
	#detector.talk_trigger.emit("Win The Game")

func evil_ball():
	evil_balls_thrown = evil_balls_thrown + 1
	if evil_balls_thrown == 1:
		dialog_box.text = "I knew we should have deployed a more… “cooperative” agent."
		yap()
		#detector.talk_trigger.emit("first evil ball")
	if evil_balls_thrown == 4:
		#detector.talk_trigger.emit("evil ball thrown")
		evil_balls_thrown = 1

func yap():
	text_duration = dialog_box.text.length() / 30.0
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(dialog_box, "visible_ratio", 1.0, text_duration)
	tween.finished
	$YapTimer.start()

func _on_yap_timer_timeout():
	dialog_box.visible_ratio = 0.0
