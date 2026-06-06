extends Control

@export var initial_health: int = 1000

@onready var health_counter: ItemCounter = $HealthCounter
@onready var health: int = initial_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_counter.update_label(health)

func _on_player_hit(damage: int) -> void:
	health = health - damage
	health_counter.update_label(health)
