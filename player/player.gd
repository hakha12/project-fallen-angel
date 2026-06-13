class_name Player
extends CharacterBody2D

signal item_collected(item_type: RigidBody2D)
signal player_hit(damage: int)

var wiggle_velocity: float = 0.0

@export var health : int = 100
@export var wiggling_speed := 80.0
@export var max_wiggle := 10.0
@export var spring_strength: float = 90.0
@export var damping: float = 10.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var hit_sound: AudioStreamPlayer2D = $HitSound

func _ready() -> void:
	animation.play("wiggle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	
		# Target rotation.
	var target_rotation := direction * max_wiggle

	# Spring behavior.
	var displacement := rotation_degrees - target_rotation
	var acceleration := (-displacement * spring_strength) - (wiggle_velocity * damping)

	wiggle_velocity += acceleration * delta
	rotation_degrees += wiggle_velocity * delta
	#if direction:
		#rotation_degrees = move_toward(rotation_degrees, direction * max_wiggle, 0.75 * wiggling_speed * delta)
		
	if wiggle_velocity > 1.0:
		sprite.flip_h = true
	elif wiggle_velocity < -1.0:
		sprite.flip_h = false


	#else:
		#rotation_degrees = move_toward(rotation_degrees, 0, 2 * wiggling_speed * delta)



	move_and_slide()
