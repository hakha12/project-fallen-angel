extends Node2D

var enemy_type: Array[PackedScene] = [
	preload("res://enemies/laughing_face.tscn"), # Laughing Face
	preload("res://enemies/succer.tscn"), # Succer
	preload("res://enemies/biblical_eye.tscn"), # Biblical Eye
	preload("res://enemies/praying_cultist.tscn") #Praying Cultist
]

var enemy_killed: int = 0

@export var min_spawn_time: float = 1.0
@export var max_spawn_time: float = 2.0
@export var min_speed: float = 100
@export var max_speed: float = 200
@export var min_scale: float = 1.0
@export var max_scale: float = 2.0

@onready var spawn_timer: Timer = $SpawnTimer

func destroy() -> void:
	for child in get_children():
		if child is Enemy: child.queue_free()

func _on_spawn_timer_timeout() -> void:
	var type = enemy_type[randi() % len(enemy_type)]
	var new_enemy := type.instantiate() as Enemy
	new_enemy.position = Vector2(randi() % 1280, randi() % 720)
	new_enemy.speed = randf_range(min_speed, max_speed)
	
	var value = randf_range(-1, 1)
	new_enemy.direction = Vector2(value,value).normalized()
	
	var scale_factor = randf_range(min_scale, max_scale)
	new_enemy.scale = Vector2(scale_factor, scale_factor)
	new_enemy.killed.connect(_on_enemy_killed)
	add_child(new_enemy)
	
	spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)

func _on_enemy_killed() -> void:
	enemy_killed += 1
