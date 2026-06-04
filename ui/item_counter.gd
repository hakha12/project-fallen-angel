extends HBoxContainer

@export var min_size: float = 64.0
@export var icon: Texture2D
@export var initial_value: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon.texture = icon
	$Icon.custom_minimum_size = Vector2(min_size, min_size)
	$Use.set_text(str(initial_value))

func update_label(data: int) -> void:
	$Use.set_text(str(data))
