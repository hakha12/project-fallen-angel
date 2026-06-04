extends Control

var coin_counter :int = 0
@export var bow_counter: int = 0
@export var super_bow_counter: int = 0
@export var sun_counter: int = 0

signal spawn_sun()
signal spawn_bow(count: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Container/Bow.update_label(bow_counter)
	$Container/SuperBow.update_label(super_bow_counter)
	$Container/Sun.update_label(sun_counter)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_sun"):
		if sun_counter > 0: spawn_sun.emit()
	if event.is_action_pressed("use_bow"):
		if bow_counter > 0: spawn_bow.emit(1)
	if event.is_action_pressed("use_super_bow"):
		if super_bow_counter > 0: spawn_bow.emit(10)

func collect_coin():
	coin_counter += 1
	$Container/Crystal.update_label(coin_counter)

func collect_bow():
	bow_counter += 1
	$Container/Bow.update_label(bow_counter)

func purchase_item(item_type: int):
	pass

func _on_player_item_collected(item: RigidBody2D) -> void:
	if item is Crystal: collect_coin()
	if item is Bow: collect_bow()

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
