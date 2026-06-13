extends Node

@onready var background_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_spawn_timer: Timer = $EnemySpawner/SpawnTimer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var day_light: DirectionalLight2D = $DayLight
@onready var night_noise: ColorRect = $NightNoise

@onready var start_button: Button = $Control/VBoxContainer/StartButton
@onready var difficulty_container: VBoxContainer = $Control/VBoxContainer/DifficultyContainer

@onready var day_bgm: AudioStreamPlayer = $DayBGM
@onready var night_bgm: AudioStreamPlayer = $NightBGM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawn_timer.start()
	background_animation.play("default")
	difficulty_container.hide()
	background_animation.speed_scale = 1.0
	day_bgm.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	background_animation.rotation_degrees += 0.1

func _setup_game(difficulty: int) -> void:
	var game: PackedScene = load("res://game.tscn")
	var game_scene: Node = game.instantiate()
	var old: Node = get_tree().current_scene
	get_tree().root.add_child(game_scene)
	get_tree().current_scene = game_scene
	old.queue_free()

func _on_start_button_pressed() -> void:
	start_button.hide()
	difficulty_container.show()


func _on_normal_difficulty_pressed() -> void:
	_setup_game(0)


func _on_hard_difficulty_pressed() -> void:
	pass # Replace with function body.


func _on_day_bgm_finished() -> void:
	background_animation.speed_scale = 2.0
	enemy_spawner.show()
	night_noise.show()
	day_light.hide()
	
	night_bgm.play()


func _on_night_bgm_finished() -> void:
	background_animation.speed_scale = 1.0
	enemy_spawner.hide()
	night_noise.hide()
	day_light.show()
	
	day_bgm.play()
