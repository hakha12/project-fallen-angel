extends Enemy

func _ready() -> void:
	super()
	
	is_floating = true

func _physics_process(delta: float) -> void:
	rotation_degrees = rotation_degrees - 1.0

	move_and_slide()
