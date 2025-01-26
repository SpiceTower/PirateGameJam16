extends Brick

class_name Generator

signal generator_destroyed

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var signal_detector: Detector = $"../SignalDetector"


func _ready():
		
	level = 5
	set_level(level)
	sprites = [
	preload("res://Base Assets/Military Brick-Sheet.png")
]

func set_level(new_level: int):
	level = new_level
	match level:
		5:
			animated_sprite_2d.play("Undamaged")
		4:
			animated_sprite_2d.play("One Damage")
		3: 
			animated_sprite_2d.play("Two Damage")
		2:
			animated_sprite_2d.play("Three Damage")
		1:
			animated_sprite_2d.play("Explode")
			$Timer.start()
			signal_detector.generator_destroyed.emit()


func _on_timer_timeout():
	decrease_level()
