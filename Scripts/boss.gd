extends RigidBody2D

class_name Boss

@export var boss_health = 1
@export var detector:Detector
@export var ball_cd = 5

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@onready var evil_ball = preload("res://Scenes/evil_ball.tscn")
@onready var ballthrown : bool = false

signal generator_destroyed

func _ready() -> void:
	animated_sprite_2d.play("default")
	detector.generator_destroyed.connect(cigar_drop)
	timer.start(ball_cd)
	

func cigar_drop():
	animated_sprite_2d.play("Drop Cigar")
	timer.start(ball_cd)

func explode():
	timer.stop()
	boss_health = boss_health -1
	animated_sprite_2d.play("Explode")
	collision_shape_2d.disabled = true

func _on_timer_timeout() -> void:
	ballthrown = true
	animated_sprite_2d.play("Throw Ball")
	timer.start(ball_cd)


func _on_animated_sprite_2d_animation_finished() -> void:
	if ballthrown == true:
		spawn_evil_ball()
		ballthrown = false
	if boss_health >= 1:
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.visible = false

func spawn_evil_ball():
	var e_ball = evil_ball.instantiate()
	get_parent().add_child(e_ball)
	e_ball.position = marker_2d.global_position
