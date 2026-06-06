extends Node2D

signal bow_used(count: int)

@export var left_spawn_limit: float = 100
@export var right_spawn_limit: float = 1180
@export var bow_scale_factor: float = 0.25

var bow: PackedScene = preload("res://item/bow.tscn")

func destroy() -> void:
	for child in get_children():
		if child is Bow: child.queue_free()


func _on_bow_spawn(count: int) -> void:
	var parent = get_parent()
	if parent is not Level: return
	
	var night: Timer = parent.get_node("NightTimer")
	if not night: return
	
	if night.is_stopped(): return
	
	for i in count:
		var new_bow = bow.instantiate() as Bow
		
		new_bow.position = Vector2(randf_range(left_spawn_limit, right_spawn_limit), randf_range(-240, -480))
		new_bow.scale = Vector2(bow_scale_factor, bow_scale_factor)
		add_child(new_bow)
		
	
	bow_used.emit(count)
	
