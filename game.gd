extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level/Player.item_collected.connect($UI/ItemManager._on_player_item_collected)
	$Level/Player.player_hit.connect($UI/HealthManager._on_player_hit)
	$UI/ItemManager.spawn_sun.connect($Level._on_spawn_sun)
	$Level/SunSpawner.sun_used.connect($UI/ItemManager._on_sun_used)
	$UI/ItemManager.spawn_bow.connect($Level/BowSpawner._on_bow_spawn)
	$Level/BowSpawner.bow_used.connect($UI/ItemManager._on_bow_used)
