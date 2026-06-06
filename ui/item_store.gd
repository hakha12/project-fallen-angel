extends Control

@export var warning_show_time: float = 0.5

signal item_selected(item: int, price: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Container/Bow/Button.pressed.connect(_on_bow_button_pressed)
	$VBoxContainer/Container/SuperBow/Button.pressed.connect(_on_super_bow_button_pressed)
	$VBoxContainer/Container/Sun/Button.pressed.connect(_on_sun_button_pressed)

func _on_bow_button_pressed() -> void:
	item_selected.emit(1, $VBoxContainer/Container/Bow.price)

func _on_super_bow_button_pressed() -> void:
	item_selected.emit(2, $VBoxContainer/Container/SuperBow.price, )



func _on_sun_button_pressed() -> void:
	item_selected.emit(3, $VBoxContainer/Container/Sun.price)

func _on_item_purchase(item_type: int, success: bool) -> void:
	if item_type == 1:
		if success:
			$VBoxContainer/Container/Bow.button_sound.play()
		else:
			$VBoxContainer/Container/Bow.button_fail_sound.play()
			$VBoxContainer/Container/Bow.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			$VBoxContainer/Container/Bow.not_enough.hide()
	elif item_type == 2:
		if success:
			$VBoxContainer/Container/SuperBow.button_sound.play()
		else:
			$VBoxContainer/Container/SuperBow.button_fail_sound.play()
			$VBoxContainer/Container/SuperBow.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			$VBoxContainer/Container/SuperBow.not_enough.hide()
	elif item_type == 3:
		if success:
			$VBoxContainer/Container/Sun.button_sound.play()
		else:
			$VBoxContainer/Container/Sun.button_fail_sound.play()
			$VBoxContainer/Container/Sun.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			$VBoxContainer/Container/Sun.not_enough.hide()
