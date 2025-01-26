extends Brick

#variation of the base brick scene that works with 'brick' bricks. Seperate ones may be needed to create glass, metal, and other bricks

@export var damagelevel = 3


func _ready():
	level = damagelevel
	sprites = [
		preload("res://Base Assets/Bricks Brick 3.png"),
		preload("res://Base Assets/Bricks Brick 2.png"),
		preload("res://Base Assets/Bricks Brick 1.png")
		]
	sprite_2d = $Sprite2D
	sprite_2d.texture = sprites[level-1]
