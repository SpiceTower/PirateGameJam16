extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	$Credits.hide()
	$SettingsBox.hide()
	#var grp = ButtonGroup.new()
	#$VBoxContainer/SettingsButton.group = grp
	#$VBoxContainer/CreditsButton.group = grp
	

func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/debriefLevel1.tscn")



func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_button_toggled(toggled_on):
	if toggled_on:
		$SettingsBox.show()
		$ColorRect2.show()
	else:
		$SettingsBox.hide()
		$ColorRect2.hide()


func _on_credits_button_toggled(toggled_on):
	if toggled_on:
		$Credits.show()
		$ColorRect3.show()
	else:
		$Credits.hide()
		$ColorRect3.hide()
