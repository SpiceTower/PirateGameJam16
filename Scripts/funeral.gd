extends Node2D

func _ready():
	$AnimationPlayer.play("RESET")

	$AnimationPlayer.play("fade")
	$FadeTimer.start()
	$AudioStreamPlayer.play()
	send_him_off()

func _process(delta):
	pass

func _on_fade_timer_timeout():
	$AnimatedSprite2D.play("default")
	$CanvasLayer/ColorRect.hide()

func send_him_off():
	await get_tree().create_timer(15.0).timeout
	$CanvasLayer/Cover.hide()
	$AnimatedSprite2D.play("the end")
	$ShadesTimer.start()
	


func _on_shades_timer_timeout():
	$AudioStreamPlayer2.play()
	$AnimatedSprite2D.play("stop")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://Scenes/true_end.tscn")
