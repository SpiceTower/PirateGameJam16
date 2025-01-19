extends Brick

#variation of the base brick scene that works with 'brick' bricks. Seperate ones may be needed to create glass, metal, and other bricks

func _ready():
	level = 3
	sprites = [
		preload("res://Base Assets/Bricks Brick 3.png"),
		preload("res://Base Assets/Bricks Brick 2.png"),
		preload("res://Base Assets/Bricks Brick 1.png")
		]
