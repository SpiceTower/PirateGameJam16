extends Node2D

#var intro_text_path = "res://Base Assets/Text/debrief2.txt"
var intro_text

var input2 = "Excellent work back there, B.411! 

You remind me of an eager, young… me. 
The final conflict is upon us and no mercy can be shown. 

Success here sets the stage for explosive growth followed by record profit. 

May the rubble you make serve as a strong foundation for our bright future!"

var input2B = "Not sure what blasted decision-making happened back there. 

We honestly didn’t anticipate that level of incompetence (though smart is also bad) so thanks to your troubleshooting, we’ve finished development of the ID-10T Proofing System.

You should feel honored.

But on to the mission.

Your focus this time, B.411, is the Enemy. 

Bring Freedom and Profit to these poor people."

@onready var exposition: RichTextLabel = $CanvasLayer/Control/Exposition

func _ready():
	$AnimationPlayer.play("RESET")
	if BackgroundProcess.get_rebel_one():
		intro_text = input2B
	else:
		intro_text = input2
	#exposition.hide()
	exposition.visible_ratio = 1.0
	exposition.text = intro_text
	$AnimationPlayer.play("fade")
	$FadeTimer.start()
	$AudioStreamPlayer.play()

func _process(delta):
	pass

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
	get_tree().change_scene_to_file("res://Scenes/Level Two.tscn")
