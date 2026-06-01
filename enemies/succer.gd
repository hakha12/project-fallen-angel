extends Enemy


func _ready() -> void:
	super()
	
	$AnimatedSprite2D.play("default")
	jump_velocity = -600
	is_floating = false

func _physics_process(delta: float) -> void:
	# Add the gravity.

	velocity += get_gravity() * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	velocity.x = direction.x * speed


	move_and_slide()
