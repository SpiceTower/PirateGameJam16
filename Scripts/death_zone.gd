extends Area2D

class_name DeathZone

signal life_lost

func _on_body_entered(_body):
	life_lost.emit()
	print("ouch")
	
