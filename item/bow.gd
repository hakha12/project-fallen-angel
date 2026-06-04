class_name Bow
extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_object_detector_body_entered(body: Node2D) -> void:
	if body is Enemy: body.queue_free()
	elif body is Player: body.item_collected.emit(self)
	
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Check only if below screen
	if position.y > 800: queue_free()
