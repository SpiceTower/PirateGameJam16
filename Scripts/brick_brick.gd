extends RigidBody2D

#variation of the base brick scene that works with 'brick' bricks. Seperate ones may be needed to create glass, metal, and other bricks

class_name BrickBrick

signal brick_destroyed

var level = 3

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

var sprites: Array[Texture2D] = [
	preload("res://Base Assets/Bricks Brick 3.png"),
	preload("res://Base Assets/Bricks Brick 2.png"),
	preload("res://Base Assets/Bricks Brick 1.png")
]

func get_size():
	return collision_shape_2d.shape.get_rect().size

func set_level(new_level: int):
	level = new_level
	sprite_2d.texture = sprites[new_level -1]

func decrease_level():
	if level > 1:
		set_level(level - 1)
	else:
		fade_out()
		
func fade_out():
	collision_shape_2d.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(destroy)

func destroy():
	queue_free()
	brick_destroyed.emit()

func get_width():
	return get_size().x
