extends Node2D

@export var min_spawn_time: float = 1.0
@export var max_spawn_time: float = 2.0
@export var left_spawn_limit: float = 500
@export var right_spawn_limit: float = 780
@export var crystal_scale_factor: float = 0.75


var crystal: PackedScene = preload("res://item/crystal.tscn")

func destroy() -> void:
	for child in get_children():
		if child is Crystal: child.queue_free()


func _on_spawn_timer_timeout() -> void:
	var new_crystal = crystal.instantiate() as Crystal
	new_crystal.position = Vector2(randf_range(left_spawn_limit, right_spawn_limit), -120)
	new_crystal.scale = Vector2(crystal_scale_factor, crystal_scale_factor)
	add_child(new_crystal)
	
	$SpawnTimer.wait_time = randf_range(min_spawn_time, max_spawn_time)
