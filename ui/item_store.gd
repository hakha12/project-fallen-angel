class_name ItemStore
extends Control

signal item_selected(item: int, price: int)

@export var warning_show_time: float = 0.5

@onready var heart: StoreCounter = $VBoxContainer/Container/Heart
@onready var bow: StoreCounter = $VBoxContainer/Container/Bow
@onready var super_bow: StoreCounter = $VBoxContainer/Container/SuperBow
@onready var sun: StoreCounter = $VBoxContainer/Container/Sun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart.button.pressed.connect(_on_heart_button_pressed)
	bow.button.pressed.connect(_on_bow_button_pressed)
	super_bow.button.pressed.connect(_on_super_bow_button_pressed)
	sun.button.pressed.connect(_on_sun_button_pressed)

func _on_bow_button_pressed() -> void:
	item_selected.emit(1, bow.price)

func _on_heart_button_pressed() -> void:
	item_selected.emit(0, heart.price)

func _on_super_bow_button_pressed() -> void:
	item_selected.emit(2, super_bow.price, )

func _on_sun_button_pressed() -> void:
	item_selected.emit(3, sun.price)

func _on_item_purchase(item_type: int, success: bool) -> void:
	if item_type == 0:
		if success:
			heart.button_sound.play()
		else:
			heart.button_fail_sound.play()
			heart.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			heart.not_enough.hide()
	elif item_type == 1:
		if success:
			bow.button_sound.play()
		else:
			bow.button_fail_sound.play()
			bow.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			bow.not_enough.hide()
	elif item_type == 2:
		if success:
			super_bow.button_sound.play()
		else:
			super_bow.button_fail_sound.play()
			super_bow.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			super_bow.not_enough.hide()
	elif item_type == 3:
		if success:
			sun.button_sound.play()
		else:
			sun.button_fail_sound.play()
			sun.not_enough.show()
		
			await get_tree().create_timer(warning_show_time).timeout

			sun.not_enough.hide()
