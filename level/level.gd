class_name Level
extends Node2D

signal game_over(night_count: int, enemy_killed: int)
signal event_triggered(night_count: int)

var night_counter: int = 0

@export var day_duration: float = 15.0
@export var night_duration: float = 30.0

@export var has_event: bool = true

@onready var player: Player = $Player
@onready var background_animation: AnimatedSprite2D = $Background/AnimatedSprite2D
@onready var day_timer: Timer = $DayTimer
@onready var night_timer: Timer = $NightTimer
@onready var night_noise: ColorRect = $NightNoise
@onready var enemy_spawn_timer: Timer = $EnemySpawner/SpawnTimer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var bow_spawner: Node2D = $BowSpawner
@onready var sun_spawner: Node2D = $SunSpawner
@onready var crystal_spawner: CrystalSpawner = $CrystalSpawner
@onready var day_bgm: AudioStreamPlayer = $DayBGM
@onready var day_light: DirectionalLight2D = $DayLight
@onready var night_bgm: AudioStreamPlayer = $NightBGM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	day_bgm.stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	day_bgm.stream.loop_begin = 0
	day_bgm.stream.loop_end = int(day_bgm.stream.get_length() * day_bgm.stream.mix_rate)


func _unhandled_input(event: InputEvent) -> void:
	# Immediately progress to night time
	if event.is_action_pressed("ui_accept"):
		if not day_timer.is_stopped():
			day_timer.timeout.emit()

func _start_new_day() -> void:
	enemy_spawn_timer.stop()
	enemy_spawner.destroy()
	crystal_spawner.spawn_timer.stop()
	crystal_spawner.destroy()
	bow_spawner.destroy()
	background_animation.speed_scale = 1.0
	night_noise.hide()

	night_timer.stop()
	night_bgm.stop()
	day_bgm.play()
	
	if has_event:
		event_triggered.emit(night_counter)
	player.sprite.modulate = Color(1, 1, 1, 1)

func _on_day_timer_timeout() -> void:
	background_animation.speed_scale = 2.0
	night_noise.show()
	day_light.hide()
	day_timer.stop()
	night_timer.wait_time = night_duration
	night_timer.start()
	enemy_spawn_timer.start()
	crystal_spawner.spawn_timer.start()
	
	day_bgm.stop()
	night_bgm.play()

func _on_night_timer_timeout() -> void:	
	night_counter += 1
	_start_new_day()


func _on_spawn_sun() -> void:
	if night_timer.is_stopped(): return
	else: 
		# Kill all enemy
		for child in enemy_spawner.get_children():
			if child is Enemy:
				child.killed.emit()
				child.queue_free()

		night_timer.timeout.emit()
		$SunSpawner.sun_used.emit()

func _on_player_died() -> void:
	player.hide()
	player.set_physics_process(false)
	night_timer.stop()
	crystal_spawner.destroy()
	crystal_spawner.spawn_timer.stop()
	bow_spawner.hide()
	enemy_spawner.destroy()
	enemy_spawner.spawn_timer.stop()
	night_bgm.stop()
	game_over.emit(night_counter, enemy_spawner.enemy_killed)

func _on_event_finished() -> void:
	day_light.show()
	day_timer.wait_time = day_duration
	day_timer.start()

func _on_game_reset() -> void:
	night_counter = 0
	_start_new_day()
	player.show()
	enemy_spawner.show()
	bow_spawner.show()
	player.set_physics_process(true)
