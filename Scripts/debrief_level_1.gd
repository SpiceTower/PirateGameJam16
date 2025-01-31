extends Node2D

#var intro_text_path = "res://Base Assets/Text/debrief1.txt"

@onready var exposition: RichTextLabel = $CanvasLayer/Control/Exposition

func _ready():
	$AnimationPlayer.play("RESET")
	var intro_text = "Agent B.411, you have access to acquire the area of armed adversaries! 

This bombastic and ballistic battle has had burgeoning bloat belittled by boasts of bygone believers and bigots.
Believe me, this contest shall conclude climatically. 
Come, let us clear this clandestine conflict! 
Devour their defenses through devious doings delightfully devoid of debt. 
Dividends divided equally will extricate extreme value after the exsanguination of their nation. 
Forever shall fervent fans fall fully for fearless felons feeding fiscal and family funds. 

Go now and gather glory for Gains, Freedom and Profit!"
	#exposition.hide()
	exposition.visible_ratio = 1.0
	exposition.text = intro_text
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
	get_tree().change_scene_to_file("res://Scenes/Level One.tscn")
