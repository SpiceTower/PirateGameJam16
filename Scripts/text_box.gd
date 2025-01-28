extends AnimatedSprite2D

@export var detector:Detector

@onready var animated_sprite_2d: AnimatedSprite2D = $"."
@onready var text_delay: Timer = $"Text Delay"

signal talk_trigger
signal stop_talking

func _ready() -> void:
	animated_sprite_2d.play("default")
	detector.talk_trigger.connect(text_box)
	

func text_box(animation_name):
	animated_sprite_2d.play(animation_name)



func _on_text_delay_timeout() -> void:
	animated_sprite_2d.play("default")
	detector.stop_talking.emit()


func _on_animation_finished() -> void:
	text_delay.start(2)
