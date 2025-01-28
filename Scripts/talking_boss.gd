extends StaticBody2D

@onready var boss: AnimatedSprite2D = $Boss
@onready var test_timer: Timer = $"Test Timer"

@export var detector: Detector

signal talk_trigger
signal stop_talking

func _ready() -> void:
	boss.play("default")
	detector.stop_talking.connect(stop_talk)
	detector.talk_trigger.connect(start_talk)

func start_talk():
	boss.play("Talking")
	test_timer.stop

func _on_test_timer_timeout() -> void:
	detector.talk_trigger.emit("Test Text")

func stop_talk():
	boss.play("default")
	test_timer.start(20)
