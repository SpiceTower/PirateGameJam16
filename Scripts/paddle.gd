extends RigidBody2D

class_name Paddle

var direction = Vector2.ZERO
var camera_rect: Rect2
var half_paddle_width: float
var is_ball_started = false

@export var speed = 1000
@export var camera: Camera2D

@onready var ball = $"../B411" as Ball
@onready var paddle = $"."
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_spite_2d = $AnimatedSpite2D



func _ready():
	ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	half_paddle_width = collision_shape_2d.shape.get_rect().size.x / 2 

func _physics_process(delta):
	linear_velocity = speed * direction
	if direction != Vector2.ZERO:
		animated_spite_2d.play("default")
	else:
		animated_spite_2d.stop()
		
		
# this bit of code is what prevents the paddle from going off the edges of the camera window. 
# Will need to be changed if the camera isn't the whole screen
func _process(delta):
	var camera_start_x = camera.position.x - camera_rect.size.x / 2 
	var camera_end_x = camera_start_x + camera_rect.size.x
	
	if global_position.x - half_paddle_width < camera_start_x:
		global_position.x = camera_start_x + half_paddle_width
	elif global_position.x + half_paddle_width > camera_end_x:
		global_position.x = camera_end_x - half_paddle_width
		
	#attempt to creat an auto paddle
	
	var ball_position = ball.global_position.x
	var paddle_position = global_position.x
	
	if paddle_position - ball_position < -half_paddle_width:
		direction = Vector2.RIGHT
	elif paddle_position - ball_position > half_paddle_width:
		direction = Vector2.LEFT
	else: 
		direction = Vector2.ZERO

func _input(event):
#	if Input.is_action_pressed("Left"):
#		direction = Vector2.LEFT
#	elif Input.is_action_pressed("Right"):
#		direction = Vector2.RIGHT
#	else:
#		direction = Vector2.ZERO

		# this bit of code is what tells the ball to start moving when the game starts or resets.
#	if direction != Vector2.ZERO && !is_ball_started:
	
	if Input.is_action_just_pressed("Start") and ball.velocity == Vector2.ZERO:
		ball.start_ball()
		is_ball_started = true

func on_ball_lost():
	is_ball_started = false
	direction = Vector2.ZERO

func get_width():
	return collision_shape_2d.shape.get_rect().size.x

func get_height():
	return collision_shape_2d.shape.get_rect().size.y

func get_velocity():
	return linear_velocity
