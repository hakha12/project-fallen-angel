extends Control

signal player_died

@export var initial_health: int = 1000

@onready var health_counter: ItemCounter = $HealthCounter
@onready var health: int = initial_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_counter.update_label(health)

func _on_health_purchased(item_type: int, success: bool) -> void:
	if success and item_type == 0:
		health += 1
		health_counter.update_label(health)

func _on_player_hit(damage: int) -> void:
	health = health - damage
	if health <= 0:
		player_died.emit()
	health_counter.update_label(health)

func _on_game_reset() -> void:
	health = initial_health
	health_counter.update_label(health)
