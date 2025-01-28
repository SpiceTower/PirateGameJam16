extends RigidBody2D

class_name EvilBall

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var ball_speed = 10


var velocity : Vector2



func _ready() -> void:
	reset_ball()
	animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * ball_speed * delta)
	if !collision: 
		return
	
	var collider = collision.get_collider()
	if collider is Brick:
		collider.decrease_level()
		explode()
	if collider is Ball:
		explode()

func reset_ball():
	#velocity = Vector2(randf_range(-1, 1), randf_range(.1, 1)).normalized() * ball_speed
	velocity = Vector2(0, 1).rotated(deg_to_rad(randf_range(-45, 45))) * ball_speed

func explode():
	animated_sprite_2d.play("Ball Explode")
	collision_shape_2d.disabled = true
	velocity = Vector2.ZERO


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
