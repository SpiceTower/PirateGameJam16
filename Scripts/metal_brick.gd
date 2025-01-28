extends Brick

func _ready():
	level = 4
	
	sprites = [
	preload("res://Base Assets/Bricks Metal 4.png"),
	preload("res://Base Assets/Bricks Metal 3.png"),
	preload("res://Base Assets/Bricks Metal 2.png"),
	preload("res://Base Assets/Bricks Metal 1.png")
]


func destroy():
	queue_free()
