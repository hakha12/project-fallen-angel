extends Node

@onready var player: Player = $Level/Player
@onready var level: Level = $Level
@onready var health_manager: Control = $UI/HealthManager
@onready var item_manager: ItemManager = $UI/ItemManager
@onready var item_store: ItemStore = $UI/ItemStore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.item_collected.connect(item_manager._on_player_item_collected)
	player.player_hit.connect(health_manager._on_player_hit)
	level.day_timer.timeout.connect(item_manager._on_day_timer_timeout)
	level.night_timer.timeout.connect(item_manager._on_night_timer_timeout)
	item_manager.spawn_sun.connect(level._on_spawn_sun)
	level.sun_spawner.sun_used.connect(item_manager._on_sun_used)
	item_manager.spawn_bow.connect(level.bow_spawner._on_bow_spawn)
	level.bow_spawner.bow_used.connect(item_manager._on_bow_used)
	item_store.item_selected.connect(item_manager._on_store_item_selected)
	item_manager.item_purchase.connect(item_store._on_item_purchase)
	
	item_manager.hide()
	item_store.hide()

func _process(delta: float) -> void:
	if level.night_counter >= 1:
		item_manager.show()
		
		if not level.day_timer.is_stopped(): item_store.show()
		else: item_store.hide()
