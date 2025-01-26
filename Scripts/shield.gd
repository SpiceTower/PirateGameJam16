extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shield_on : bool = true

@export var shield_health = 2
@export var detector:Detector

signal generator_destroyed

func _ready():
	detector.generator_destroyed.connect(shield_check)

func shield_check():
	shield_health = shield_health - 1
	
	if shield_health == 0:
		sprite_2d.set_frame(1)
		collision_shape_2d.disabled = true
