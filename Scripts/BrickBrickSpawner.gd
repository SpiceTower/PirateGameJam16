extends Node

#currently connected spawner. This has been modified to only spawn 'brick' tier bricks with no variation. 
#not sure how to make this spawn all of the brick types without extensive rewrites. We may want to manually spawn bricks anyways. 

class_name BrickBrickSpawner

const COLUMNS = 5
const ROWS = 6

@onready var ball = $"../B411" as Ball
@onready var ui = $"../UI" as UI

@export var brick_scene: PackedScene
@export var margin: Vector2 = Vector2(8,8)
@export var spawn_start: Marker2D

var brick_count = 0

func _ready():
	spawn()

func spawn():
	var test_brick = brick_scene.instantiate() as BrickBrick
	add_child(test_brick)
	var brick_size = test_brick.get_size()
	test_brick.queue_free()
	
	var row_width = brick_size.x * COLUMNS + margin.x * (COLUMNS - 1)
	var spawn_poistion_x = (-row_width + brick_size.x + margin.x) / 2
	var spawn_poistion_y = spawn_start.position.y
	
	for i in ROWS:
		for j in COLUMNS:
			var brick = brick_scene.instantiate() as BrickBrick
			add_child(brick)
			brick.set_level(3)
			var x = spawn_poistion_x + j * (margin.x + brick.get_size().x)
			var y = spawn_poistion_y + i * (margin.y + brick.get_size().y)
			brick.set_position(Vector2(x,y))
			brick.brick_destroyed.connect(on_brick_destroyed)
			
func on_brick_destroyed():
	brick_count -= 1
	if brick_count == 0:
		ball.stop_ball
		
