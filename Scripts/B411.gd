extends CharacterBody2D

class_name Ball

signal life_lost #connected to the death_zone node

const VELOCITY_LIMIT = 40 #I'm not certain this does anything

@export var ball_speed = 20
@export var lifes = 3
@export var death_zone : DeathZone
@export var ui : UI
@export var boost = 30

var speed_up_factor = 1.01
var last_collider_id
var start_postion: Vector2
var boost_ready : bool = true

@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	ui.set_lifes(lifes)
	start_postion = position
	death_zone.life_lost.connect(on_life_lost)
	animated_sprite_2d.play("default")

func _physics_process(delta): #manages all movement of the ball, currently can only be connected to a single kind of brick (BrickBrick) 
	ui.set_boost(boost_ready)
	var collision = move_and_collide(velocity * ball_speed * delta)
	if(!collision):
		return
		
	var collider = collision.get_collider()
	if collider is Brick:
		collider.decrease_level()
	
	if (collider is Brick or collider is Paddle):
		ball_collision(collider)
	else:
		velocity = velocity.bounce(collision.get_normal())

#attempting to add player input to effect the ball
func _input(event):
	if Input.is_action_just_pressed("Up") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Up")
		velocity = velocity + (Vector2(0,-1) * boost) 
	elif Input.is_action_just_pressed("Down") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Down")
		velocity = velocity + (Vector2(0,1) * boost) 
	elif Input.is_action_just_pressed("Right") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Right")
		velocity = velocity + (Vector2(1,0) * boost) 
	elif Input.is_action_just_pressed("Left") and boost_ready == true:
		boost_ready = false
		$Timer.start()
		animated_sprite_2d.play("Left")
		velocity = velocity + (Vector2(-1,0) * boost) 
	else:
		animated_sprite_2d.play("default")
		return


# randomized the starting direction of the ball. Not sure if this is how we want to start levels but is a simple default 
func start_ball():
	position = start_postion
	randomize()
	
	velocity = Vector2(randf_range(-1, 1), randf_range(-.1, -1)).normalized() *ball_speed

func on_life_lost():
	lifes -= 1
	if lifes == 0 :
		ui.game_over()
	else:
		life_lost.emit()
		reset_ball()
		ui.set_lifes(lifes)

#after the ball is lost, this is will reset the ball to the spawn position. If we change the default we will need to consider this too
func reset_ball():
	position = start_postion
	velocity = Vector2.ZERO

# This obnoxious bit of code is to create variation in the ball bounces. It speeds up the ball when it hits bricks/paddle and makes the bounce direction
#- contingent on where the ball hits the paddle or brick. Good to have, stupid to look at. 
func ball_collision(collider):
	
	var ball_width = collision_shape_2d.shape.get_rect().size.x
	var ball_center_x = position.x
	var collider_width = collider.get_width()
	var collider_center_x = collider.position.x
	
	var velocity_xy = velocity.length()
	
	var collision_x = (ball_center_x - collider_center_x) / (collider_width / 2)
	
	var new_velocity = Vector2.ZERO
	
	new_velocity.x = velocity_xy * collision_x
	
	if collider.get_rid() == last_collider_id && collider is Brick:
		new_velocity.x = new_velocity.rotated(deg_to_rad(randf_range(-45,45))).x *10
	else:
		last_collider_id == collider.get_rid()
	
	new_velocity.y = sqrt(absf(velocity_xy * velocity_xy - new_velocity.x * new_velocity.x)) *(-1 if velocity.y > 0 else 1)
	
	var speed_multiplier = speed_up_factor if collider is Paddle else 1
	
	velocity = (new_velocity * speed_multiplier).limit_length(VELOCITY_LIMIT)


func _on_timer_timeout():
	boost_ready = true # Replace with function body.
