extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")
	$PanelContainer/VBoxContainer/ResumeButton.grab_focus()
	$".".hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	$".".hide()

func pause():
	$".".show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AnimationPlayer.play("blur")

func _on_pause_pressed():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()

func _on_resume_button_pressed():
	resume()


func _on_main_menu_button_pressed():
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

func _process(delta):
	_on_pause_pressed()
	
