class_name Enemy
extends CharacterBody2D

var speed: float = 300.0
var is_floating: bool = false
var jump_velocity: float = 0
var jump_timer: float = 1.0
var direction: Vector2

@onready var object_detector = {
	"up": $DetectorUp,
	"down": $DetectorDown,
	"left": $DetectorLeft,
	"right": $DetectorRight,
}

func _ready() -> void:
	$JumpTimer.wait_time = jump_timer
	
	if $AnimatedSprite2D.sprite_frames != null:
		$AnimatedSprite2D.play("default")

func _on_jump_timer_timeout() -> void:
	if is_floating: return #Use separate method for moving in Y axis when floating
	velocity.y = jump_velocity

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player: body.player_hit.emit(1)
