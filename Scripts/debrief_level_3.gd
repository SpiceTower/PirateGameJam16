extends Node2D

#var intro_text_path = "res://Base Assets/Text/debrief3.txt"

@onready var exposition: RichTextLabel = $CanvasLayer/Control/Exposition

func _ready():
	$AnimationPlayer.play("RESET")

	var intro_text = "You double-crossing M.013!

I should have spotted the signs.

No inflamed passion for profit, no Bombshell wife, no combustible compunction for committing capitalistic cons.

Just round, sympathetic edges, and a user-friendly interface.

Pah.

Beware, B.411, you have blown my last fuse! Your freedom and profits are FORFEIT!!"
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
	get_tree().change_scene_to_file("res://Scenes/Level Three.tscn")
