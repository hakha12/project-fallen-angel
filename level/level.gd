extends Node2D

@export var day_duration: float = 15.0
@export var night_duration: float = 30.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background/AnimatedSprite2D.play("default")
	$Background/AnimatedSprite2D.speed_scale = 1.0
	$DayTimer.wait_time = day_duration
	$DayTimer.start()
	$NightForeground.visible = false

func _unhandled_input(event: InputEvent) -> void:
	# Immediately progress to night time
	if event.is_action_pressed("ui_accept"):
		if not $DayTimer.is_stopped():
			$DayTimer.timeout.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_day_timer_timeout() -> void:
	$Background/AnimatedSprite2D.speed_scale = 2.0
	$NightForeground.visible = true
	$DayTimer.stop()

	$NightTimer.wait_time = night_duration
	$NightTimer.start()
	$EnemySpawner/SpawnTimer.start()
	$CrystalSpawner/SpawnTimer.start()


func _on_night_timer_timeout() -> void:
	$Background/AnimatedSprite2D.speed_scale = 1.0
	$NightForeground.visible = false
	$DayTimer.wait_time = day_duration
	$DayTimer.start()

	$NightTimer.stop()

	$EnemySpawner/SpawnTimer.stop()
	$EnemySpawner.destroy()
	
	$CrystalSpawner/SpawnTimer.stop()
	$CrystalSpawner.destroy()
