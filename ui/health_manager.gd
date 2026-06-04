extends Control

@export var initial_health: int = 1000

@onready var health: int = initial_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthCounter.update_label(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_hit(damage: int) -> void:
	health = health - damage
	$HealthCounter.update_label(health)
