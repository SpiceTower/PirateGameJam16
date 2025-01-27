extends RigidBody2D

class_name Paddle

const paddle_y = 250

signal paddle_hit

var direction = Vector2.ZERO
var camera_rect: Rect2
var ball_paddle_diff_tolerance: float
var is_ball_started = false
var paddle_frozen = false

@export var speed = 750
@export var camera: Camera2D

@onready var ball = $"../B411" as Ball
@onready var paddle = $"."
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_spite_2d = $AnimatedSpite2D



func _ready():
	#ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	ball_paddle_diff_tolerance = collision_shape_2d.shape.get_rect().size.x / 4 

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
	var ball_position_y = ball.global_position.y
	

	if global_position.x - ball_paddle_diff_tolerance < camera_start_x:
		global_position.x = camera_start_x + ball_paddle_diff_tolerance
	elif global_position.x + ball_paddle_diff_tolerance > camera_end_x:
		global_position.x = camera_end_x - ball_paddle_diff_tolerance
	
	
	if global_position.y - ball_position_y <= 0 && collision_shape_2d.disabled == false: 
		collision_shape_2d.disabled = true
	
	if collision_shape_2d.disabled == true && (global_position.y - ball_position_y) > 50:
		collision_shape_2d.disabled = false
		
		
	#attempt to creat an auto paddle
	
	var ball_position = ball.global_position.x
	
	var paddle_position = global_position.x
	
	if paddle_frozen == false:
		if paddle_position - ball_position < -ball_paddle_diff_tolerance:
			direction = Vector2.RIGHT
		elif paddle_position - ball_position > ball_paddle_diff_tolerance:
			direction = Vector2.LEFT
		else: 
			direction = Vector2.ZERO
	else: 
		direction = Vector2.ZERO


func _on_b_411_paddle_hit():
	$Timer.start()
	paddle_frozen = true
	if global_position.y != paddle_y:
		global_position.y = paddle_y


func _on_timer_timeout():
	paddle_frozen = false

#func _input(event):
#	if Input.is_action_pressed("Left"):
#		direction = Vector2.LEFT
#	elif Input.is_action_pressed("Right"):
#		direction = Vector2.RIGHT
#	else:
#		direction = Vector2.ZERO

		# this bit of code is what tells the ball to start moving when the game starts or resets.
#	if direction != Vector2.ZERO && !is_ball_started:
	
	#if Input.is_action_pressed("Start") and ball.velocity == Vector2.ZERO:
		#ball.start_ball()
		#is_ball_started = true
		#print("start")

#func on_ball_lost():
	#is_ball_started = false
	#direction = Vector2.ZERO

func get_width():
	return collision_shape_2d.shape.get_rect().size.x

func get_height():
	return collision_shape_2d.shape.get_rect().size.y

func get_velocity():
	return linear_velocity
