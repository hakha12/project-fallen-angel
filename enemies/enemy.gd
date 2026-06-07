class_name Enemy
extends CharacterBody2D

signal killed

var speed: float = 300.0
var is_floating: bool = false
var jump_velocity: float = 0
var jump_timer_interval: float = 1.0
var direction: Vector2

@onready var object_detector = {
	"up": $DetectorUp,
	"down": $DetectorDown,
	"left": $DetectorLeft,
	"right": $DetectorRight,
}

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var jump_timer: Timer = $JumpTimer

func _ready() -> void:
	jump_timer.wait_time = jump_timer_interval
	
	if animation.sprite_frames != null:
		animation.play("default")

func _on_jump_timer_timeout() -> void:
	if is_floating: return #Use separate method for moving in Y axis when floating
	velocity.y = jump_velocity

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player: 
		body.player_hit.emit(1)
		body.sprite.modulate = Color(255, 0, 0)
		
		await get_tree().create_timer(0.25).timeout
		
		body.sprite.modulate = Color(1, 1, 1, 1)

func _on_death_sound_finished() -> void:
	killed.emit()
	queue_free()
