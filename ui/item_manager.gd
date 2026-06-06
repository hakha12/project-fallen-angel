class_name ItemManager
extends Control

signal spawn_sun()
signal spawn_bow(count: int)
signal item_purchase(item_type: int, success: bool)

@export var coin_counter :int = 0
@export var bow_counter: int = 0
@export var super_bow_counter: int = 0
@export var sun_counter: int = 0
@export var warning_show_time: float = 0.5

@onready var crystal: ItemCounter = $Container/Crystal
@onready var bow: ItemCounter = $Container/Bow
@onready var super_bow: ItemCounter = $Container/SuperBow
@onready var sun: ItemCounter = $Container/Sun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crystal.update_label(coin_counter)
	bow.update_label(bow_counter)
	super_bow.update_label(super_bow_counter)
	sun.update_label(sun_counter)
	
	bow.button.pressed.connect(_on_bow_button_pressed)
	super_bow.button.pressed.connect(_on_super_bow_button_pressed)
	sun.button.pressed.connect(_on_sun_button_pressed)

func collect_coin():
	coin_counter += 1
	crystal.update_label(coin_counter)

func collect_bow():
	bow_counter += 1
	bow.update_label(bow_counter)

func _on_store_item_selected(item_type: int, price: int):
	var success
	if price > coin_counter: 
		success = false
	else:
		if item_type == 1: 
			bow_counter += 1
			bow.update_label(bow_counter)
		elif item_type == 2: 
			super_bow_counter += 1
			super_bow.update_label(super_bow_counter)
		elif item_type == 3: 
			sun_counter += 1
			sun.update_label(sun_counter)
	
		success = true
		coin_counter -= price
		crystal.update_label(coin_counter)
	
	item_purchase.emit(item_type, success)

func _on_day_timer_timeout() -> void:
	bow.button.disabled = false
	super_bow.button.disabled = false
	sun.button.disabled = false

func _on_night_timer_timeout() -> void:
	bow.button.disabled = true
	super_bow.button.disabled = true
	sun.button.disabled = true

func _on_player_item_collected(item: RigidBody2D) -> void:
	if item is Crystal: collect_coin()
	if item is Bow: collect_bow()

func _on_bow_button_pressed() -> void:
	if bow_counter > 0: 
		bow.button_sound.play()
		spawn_bow.emit(1)
	else:
		bow.button_fail_sound.play()
		bow.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		bow.not_enough.hide()

func _on_super_bow_button_pressed() -> void:
	if super_bow_counter > 0: 
		super_bow.button_sound.play()
		spawn_bow.emit(10)
	else:
		super_bow.button_fail_sound.play()
		super_bow.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		super_bow.not_enough.hide()

func _on_sun_button_pressed() -> void:
	if sun_counter > 0: 
		sun.button_sound.play()
		spawn_sun.emit()
	else:
		sun.button_fail_sound.play()
		sun.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		sun.not_enough.hide()

func _on_sun_used() -> void:
	sun_counter -= 1
	sun.update_label(sun_counter)

func _on_bow_used(count: int) -> void:
	if count == 1:
		bow_counter -= 1
		bow.update_label(bow_counter)
	else:
		super_bow_counter -= 1
		super_bow.update_label(super_bow_counter)
