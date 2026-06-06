class_name Level
extends Node2D

var night_counter: int = 0

@export var day_duration: float = 15.0
@export var night_duration: float = 30.0

@onready var background_animation: AnimatedSprite2D = $Background/AnimatedSprite2D
@onready var day_timer: Timer = $DayTimer
@onready var night_timer: Timer = $NightTimer
@onready var night_foreground: ColorRect = $NightForeground
@onready var night_noise: ColorRect = $NightNoise
@onready var enemy_spawn_timer: Timer = $EnemySpawner/SpawnTimer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var bow_spawner: Node2D = $BowSpawner
@onready var sun_spawner: Node2D = $SunSpawner
@onready var crystal_spawner: CrystalSpawner = $CrystalSpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_animation.play("default")
	background_animation.speed_scale = 1.0
	day_timer.wait_time = day_duration
	day_timer.start()
	night_foreground.hide()
	night_noise.hide()

func _unhandled_input(event: InputEvent) -> void:
	# Immediately progress to night time
	if event.is_action_pressed("ui_accept"):
		if not day_timer.is_stopped():
			day_timer.timeout.emit()

func _on_day_timer_timeout() -> void:
	background_animation.speed_scale = 2.0
	night_foreground.show()
	night_noise.show()
	day_timer.stop()
	night_timer.wait_time = night_duration
	night_timer.start()
	enemy_spawn_timer.start()
	crystal_spawner.spawn_timer.start()

func _on_night_timer_timeout() -> void:
	background_animation.speed_scale = 1.0
	night_foreground.hide()
	night_noise.hide()
	day_timer.wait_time = day_duration
	day_timer.start()
	night_timer.stop()
	night_duration += 1
	night_counter += 1
	
	enemy_spawn_timer.stop()
	enemy_spawner.destroy()
	crystal_spawner.spawn_timer.stop()
	crystal_spawner.destroy()
	bow_spawner.destroy()

func _on_spawn_sun() -> void:
	if night_timer.is_stopped(): return
	else: 
		night_timer.timeout.emit()
		$SunSpawner.sun_used.emit()
