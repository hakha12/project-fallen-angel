extends Enemy



func _ready() -> void:
	super()
	
	is_floating = false
	jump_velocity = -800

func _physics_process(delta: float) -> void:
	# Add the gravity.

	velocity += get_gravity() * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.



	move_and_slide()
