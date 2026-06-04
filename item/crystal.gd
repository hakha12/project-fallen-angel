class_name Crystal
extends RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		body.item_collected.emit(self)
		queue_free()
