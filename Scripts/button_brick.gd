extends Brick

@export var damagelevel = 4

func _ready():
	buttonbrick = true
	
	level = damagelevel
	
	sprites = [
	preload("res://Base Assets/Button Brick 4.png"),
	preload("res://Base Assets/Button Brick 3.png"),
	preload("res://Base Assets/Button Brick 2.png"),
	preload("res://Base Assets/Button Brick 1.png")
]
	sprite_2d = $Sprite2D
	sprite_2d.texture = sprites[level-1]
