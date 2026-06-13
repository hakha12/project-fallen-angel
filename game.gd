extends Node

@onready var player: Player = $Level/Player
@onready var level: Level = $Level
@onready var health_manager: Control = $UI/HealthManager
@onready var item_manager: ItemManager = $UI/ItemManager
@onready var item_store: ItemStore = $UI/ItemStore
@onready var game_over: GameOver = $UI/GameOver
@onready var event_text: EventText = $EventTextBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.event_triggered.connect(event_text._on_event_started)
	event_text.event_finished.connect(level._on_event_finished)
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
	item_manager.item_purchase.connect(health_manager._on_health_purchased)
	health_manager.player_died.connect(level._on_player_died)
	level.game_over.connect(item_manager._on_game_over)
	level.game_over.connect(game_over._on_game_over)
	game_over.game_reset.connect(level._on_game_reset)
	game_over.game_reset.connect(item_manager._on_game_reset)
	game_over.game_reset.connect(health_manager._on_game_reset)
	
	level._start_new_day()

func _process(delta: float) -> void:
	if not is_instance_valid(level):
		return

	if level.night_counter >= 1:
		item_manager.show()
		
		if not level.day_timer.is_stopped(): item_store.show()
		else: item_store.hide()
