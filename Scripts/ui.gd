extends CanvasLayer

class_name UI

@onready var lifes_label = %LifesLabel
@onready var game_lost_container = $GameLostContainer
@onready var boost_ready = $MarginContainer/HBoxContainer/BoostReady

func set_lifes(lifes: int):
	lifes_label.text = "Lifes: %d" % lifes

func set_boost(boost: bool):
	if boost == true:
		boost_ready.text = "Boost Ready" 
	else:
		boost_ready.text = "No Boost For You"
	
func game_over():
	game_lost_container.show()

func _on_game_lost_button_pressed():
	get_tree().reload_current_scene()
