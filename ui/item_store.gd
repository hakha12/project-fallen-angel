extends Control

signal item_selected(item: int, price: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Container/Bow/Button.pressed.connect(_on_bow_button_pressed)
	$VBoxContainer/Container/SuperBow/Button.pressed.connect(_on_super_bow_button_pressed)
	$VBoxContainer/Container/Sun/Button.pressed.connect(_on_sun_button_pressed)

func _on_bow_button_pressed() -> void:
	item_selected.emit(1, $VBoxContainer/Container/Bow.price)

func _on_super_bow_button_pressed() -> void:
	item_selected.emit(2, $VBoxContainer/Container/SuperBow.price)

func _on_sun_button_pressed() -> void:
	item_selected.emit(3, $VBoxContainer/Container/Sun.price)
