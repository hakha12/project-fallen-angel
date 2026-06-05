extends VBoxContainer

@export var item_name: String
@export var min_size: float = 48.0
@export var icon: Texture2D
@export var price: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.set_text(item_name)
	$Icon.texture = icon
	$Icon.custom_minimum_size = Vector2(min_size, min_size)
	$Button.set_text("Buy\n" + str(price))
