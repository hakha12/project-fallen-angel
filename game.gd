extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level/Player.item_collected.connect($UI/ItemManager._on_player_item_collected)
	$Level/Player.player_hit.connect($UI/HealthManager._on_player_hit)
	$Level/DayTimer.timeout.connect($UI/ItemManager._on_day_timer_timeout)
	$Level/NightTimer.timeout.connect($UI/ItemManager._on_night_timer_timeout)
	$UI/ItemManager.spawn_sun.connect($Level._on_spawn_sun)
	$Level/SunSpawner.sun_used.connect($UI/ItemManager._on_sun_used)
	$UI/ItemManager.spawn_bow.connect($Level/BowSpawner._on_bow_spawn)
	$Level/BowSpawner.bow_used.connect($UI/ItemManager._on_bow_used)
	$UI/ItemStore.item_selected.connect($UI/ItemManager._on_store_item_selected)
	$UI/ItemManager.item_purchase.connect($UI/ItemStore._on_item_purchase)
	
	$UI/ItemManager.hide()
	$UI/ItemStore.hide()

func _process(delta: float) -> void:
	if $Level.night_counter >= 1:
		$UI/ItemManager.show()
		
		if not $Level/DayTimer.is_stopped(): $UI/ItemStore.show()
		else: $UI/ItemStore.hide()
