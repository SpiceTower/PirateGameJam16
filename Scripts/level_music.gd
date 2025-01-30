extends AudioStreamPlayer

func _on_b_411_life_start():
	if playing == false:
		play()

var chord_list = [
	[15, 4, 9],
	[17, 4, 13],
	[15, 3, 7],
	[8, 15, 4],
	[15, 3, 7],
	[8, 17, 4],
	[15, 2, 16],
	[6, 15, 2],
	[12, 17, 4],
	[17, 4, 9],
	[4, 9, 16],
	[9, 16, 5],
	[15, 4, 9],
	[3, 7, 13],
	[4, 9, 16],
	[15, 4, 9],
	[15, 4, 9],
	[17, 4, 13],
	[15, 3, 7],
	[8, 15, 4],
	[15, 3, 7],
	[8, 17, 4],
	[15, 2, 16],
	[6, 15, 2],
	[12, 17, 4],
	[17, 4, 9],
	[4, 9, 16],
	[9, 16, 5],
	[15, 4, 9],
	[3, 7, 13],
	[4, 9, 16],
	[15, 4, 9],
	[1, 4, 11],
	[14, 1, 4],
	[17, 3, 7],
	[1, 4, 11],
	[4, 11, 16],
	[3, 7, 16],
	[10, 17, 3],
	[17, 3, 7],
	[15, 4, 9],
	[4, 9, 18],
	[4, 9, 16],
	[1, 4, 9],
	[15, 3, 7],
	[15, 3, 7],
	[15, 4, 9],
	[8, 15, 4]
]
# Called when the node enters the scene tree for the first time.
#func _ready():
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
