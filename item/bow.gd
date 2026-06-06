class_name Bow
extends RigidBody2D

func _on_object_detector_body_entered(body: Node2D) -> void:
	if body is Enemy: 
		body.death_sound.play()
		body.modulate = Color(255, 0, 0)
		body.set_physics_process(false)
	elif body is Player: body.item_collected.emit(self)
	
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Check only if below screen
	if position.y > 800: queue_free()
