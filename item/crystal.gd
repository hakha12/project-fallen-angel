class_name Crystal
extends RigidBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animation.play("default")

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		body.sprite.modulate = Color(255, 255, 0)
		
		await get_tree().create_timer(0.1).timeout
		
		body.sprite.modulate = Color(1, 1, 1, 1)
		body.item_collected.emit(self)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Check only if below screen
	if position.y > 800: queue_free()
