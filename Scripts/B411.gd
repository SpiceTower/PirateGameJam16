extends CharacterBody2D

class_name Ball

signal life_start #resets music
signal life_lost #connected to the death_zone node

const VELOCITY_MIN = 10 #The lower bound for the speed of the ball
const VELOCITY_MAX = 40 #The upper bound for speed of the ball

@export var ball_speed = 20
@export var lives = 3
@export var death_zone : DeathZone
@export var ui : UI
@export var boost = 30

var speed_up_factor = 1.01
var last_collider_id
var start_postion: Vector2
var boost_ready : bool = true
var player_control : bool = false

@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	ui.set_lives(lives)
	start_postion = position
	death_zone.life_lost.connect(on_life_lost)
	animated_sprite_2d.play("default")
	reset_ball()

func _physics_process(delta: float) -> void: #manages all movement of the ball, currently can only be connected to a single kind of brick (BrickBrick) 
	ui.set_boost(boost_ready)
	var collision = move_and_collide(velocity * ball_speed * delta)
	if !collision: 
		return
		
	var collider = collision.get_collider()
	if collider is Brick:
		collider.decrease_level()
		
	if collider is Brick or collider is Paddle:
		ball_collision(collision, collider)
	else:
		velocity = velocity.bounce(collision.get_normal())
	
	$BounceSound.play_bounce_sound()

#attempting to add player input to effect the ball
func _input(event):
	if player_control == false:
		return
	if Input.is_action_just_pressed("Up") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Up")
		velocity = velocity + (Vector2(0,-1) * boost)
		min_velocity_check()
	elif Input.is_action_just_pressed("Down") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Down")
		velocity = velocity + (Vector2(0,1) * boost)
		min_velocity_check()
	elif Input.is_action_just_pressed("Right") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Right")
		velocity = velocity + (Vector2(1,0) * boost)
		min_velocity_check()
	elif Input.is_action_just_pressed("Left") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Left")
		velocity = velocity + (Vector2(-1,0) * boost)
		min_velocity_check()
	else:
		animated_sprite_2d.play("default")
		return

#requires ball to move at a minimum velocity
func min_velocity_check():
	if velocity.length() < VELOCITY_MIN:
		velocity = velocity.normalized() * VELOCITY_MIN
	#print(velocity.length())

# randomized the starting direction of the ball. Not sure if this is how we want to start levels but is a simple default 
#func start_ball():
	#position = start_postion
	#randomize()
	
	#velocity = Vector2(randf_range(-1, 1), randf_range(-.1, -1)).normalized() * ball_speed

func on_life_lost():
	lives -= 1
	if lives == 0 :
		ui.game_over()
	else:
		life_lost.emit()
		ui.set_lives(lives)
		reset_ball()

#ran at level start and after death. resets ball position, resets music, 
#shoots ball in random direction
func reset_ball():
	player_control = false
	position = start_postion
	velocity = Vector2.ZERO
	life_start.emit()
	await get_tree().create_timer(2.0).timeout
	velocity = Vector2(randf_range(-1, 1), randf_range(-.1, -1)).normalized() * ball_speed
	player_control = true


# This obnoxious bit of code is to create variation in the ball bounces. It speeds up the ball when it hits bricks/paddle and makes the bounce direction
#- contingent on where the ball hits the paddle or brick. Good to have, stupid to look at. 
func ball_collision(collision, collider):
	
	var ball_center_x = position.x
	var collider_width = collider.get_width()
	var collider_center_x = collider.position.x
	var collision_x = (ball_center_x - collider_center_x) / (collider_width / 2)
	
	var ball_center_y = position.y
	var collider_height = collider.get_height()
	var collider_center_y = collider.position.y
	var collision_y = (ball_center_y - collider_center_y) / (collider_height / 2)
	
	var velocity_xy = velocity.length()
	
	var new_velocity = Vector2.ZERO
	
	new_velocity.x = velocity_xy * collision_x
	
	if collider.get_rid() == last_collider_id && collider is Brick:
		new_velocity.x = new_velocity.rotated(deg_to_rad(randf_range(-45,45))).x * 10
	else:
		last_collider_id == collider.get_rid()
	
	if collider is Paddle:
		new_velocity.y = sqrt(absf(velocity_xy * velocity_xy - new_velocity.x * new_velocity.x)) * (-1 if velocity.y > 0 else 1)
	elif collider is Brick:
		new_velocity.y = velocity_xy * collision_y
	
	var speed_multiplier = speed_up_factor if collider is Paddle else 1
	
	velocity = (new_velocity * speed_multiplier).limit_length(VELOCITY_MAX)
	min_velocity_check()

func _on_timer_timeout():
	boost_ready = true # Replace with function body.
