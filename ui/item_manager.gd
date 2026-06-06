extends Control

@export var coin_counter :int = 0
@export var bow_counter: int = 0
@export var super_bow_counter: int = 0
@export var sun_counter: int = 0
@export var warning_show_time: float = 0.5

signal spawn_sun()
signal spawn_bow(count: int)

signal item_purchase(item_type: int, success: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Container/Crystal.update_label(coin_counter)
	$Container/Bow.update_label(bow_counter)
	$Container/SuperBow.update_label(super_bow_counter)
	$Container/Sun.update_label(sun_counter)
	
	$Container/Bow/Button.pressed.connect(_on_bow_button_pressed)
	$Container/SuperBow/Button.pressed.connect(_on_super_bow_button_pressed)
	$Container/Sun/Button.pressed.connect(_on_sun_button_pressed)

func collect_coin():
	coin_counter += 1
	$Container/Crystal.update_label(coin_counter)

func collect_bow():
	bow_counter += 1
	$Container/Bow.update_label(bow_counter)

func _on_store_item_selected(item_type: int, price: int):
	var success
	if price > coin_counter: 
		success = false
	else:
		if item_type == 1: 
			bow_counter += 1
			$Container/Bow.update_label(bow_counter)
		elif item_type == 2: 
			super_bow_counter += 1
			$Container/SuperBow.update_label(super_bow_counter)
		elif item_type == 3: 
			sun_counter += 1
			$Container/Sun.update_label(sun_counter)
	
		success = true
	
		coin_counter -= price
		$Container/Crystal.update_label(coin_counter)
	
	item_purchase.emit(item_type, success)

func _on_day_timer_timeout() -> void:
	$Container/Bow/Button.disabled = false
	$Container/SuperBow/Button.disabled = false
	$Container/Sun/Button.disabled = false

func _on_night_timer_timeout() -> void:
	$Container/Bow/Button.disabled = true
	$Container/SuperBow/Button.disabled = true
	$Container/Sun/Button.disabled = true

func _on_player_item_collected(item: RigidBody2D) -> void:
	if item is Crystal: collect_coin()
	if item is Bow: collect_bow()

func _on_bow_button_pressed() -> void:
	if bow_counter > 0: 
		$Container/Bow.button_sound.play()
		spawn_bow.emit(1)
	else:
		$Container/Bow.button_fail_sound.play()
		$Container/Bow.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		$Container/Bow.not_enough.hide()

func _on_super_bow_button_pressed() -> void:
	if super_bow_counter > 0: 
		$Container/SuperBow.button_sound.play()
		spawn_bow.emit(10)
	else:
		$Container/SuperBow.button_fail_sound.play()
		$Container/SuperBow.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		$Container/SuperBow.not_enough.hide()

func _on_sun_button_pressed() -> void:
	if sun_counter > 0: 
		$Container/Sun.button_sound.play()
		spawn_sun.emit()
	else:
		$Container/Sun.button_fail_sound.play()
		$Container/Sun.not_enough.show()
		
		await get_tree().create_timer(warning_show_time).timeout

		$Container/Sun.not_enough.hide()

func _on_sun_used() -> void:
	sun_counter -= 1
	$Container/Sun.update_label(sun_counter)

func _on_bow_used(count: int) -> void:
	if count == 1:
		bow_counter -= 1
		$Container/Bow.update_label(bow_counter)
	else:
		super_bow_counter -= 1
		$Container/SuperBow.update_label(super_bow_counter)
