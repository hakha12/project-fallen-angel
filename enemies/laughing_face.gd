extends Enemy

func _ready() -> void:
	super()
	
	is_floating = true

func _physics_process(delta: float) -> void:
	if object_detector["right"].is_colliding():
		direction.x = -1
	elif object_detector["left"].is_colliding():
		direction.x = 1

	velocity.x = direction.x * speed
	#velocity.y = direction.y * speed
	
	rotation_degrees = rotation_degrees + 2.0

	move_and_slide()
