extends Node2D

func _ready():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("fade")
	$FadeTimer.start()
	$AudioStreamPlayer.play()

func _process(delta):
	pass

func _on_fade_timer_timeout():
	$CanvasLayer/ColorRect.hide()


func _on_next_button_pressed():
	BackgroundProcess.reset_bgp()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
