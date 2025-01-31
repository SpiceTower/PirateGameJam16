extends Node2D

#var intro_text_path = "res://Base Assets/Text/intro_text.txt"

@onready var exposition: RichTextLabel = $CanvasLayer/Control/Exposition

func _ready():
	$AnimationPlayer.play("RESET")
	$CanvasLayer/StartButton.grab_focus()
	var intro_text = "The Conflict began over 20 years ago…
	
The Enemy was dastardly and devious, and worst of all: they were resistant. 
They brought us to the brink of collapse... 

But just when hope threatened to fade away forever... 

A breakthrough! 

The B program allowed Us to tear down their defenses systematically and mount an awe-inspiring offensive. 
We will finally bring an end to this senseless struggle! The time for the final assault is upon Us! 
														For Freedom! For Profit!"
	#exposition.hide()
	exposition.visible_ratio = 1.0
	exposition.text = intro_text


func _on_start_button_pressed():
	$CanvasLayer/StartButton.hide()
	$AnimationPlayer.play("fade")
	$FadeTimer.start()
	$AudioStreamPlayer.play()

func _on_fade_timer_timeout():
	$AnimatedSprite2D.play("default")
	$CanvasLayer/ColorRect.hide()
	#var text_duration = exposition.text.length() / 120.0
	#var tween = create_tween()
	#tween.set_ease(Tween.EASE_IN)
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.tween_property(exposition, "visible_ratio", 1.0, text_duration)
	#tween.finished
	#$AnimationPlayer.play("intro_yap")
	exposition.show()


func _on_next_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
