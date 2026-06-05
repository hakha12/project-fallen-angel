extends HBoxContainer

@export var min_size: float = 48.0
@export var icon: Texture2D
@export var initial_value: int = 0
@export var has_use_button: bool = true
@export var keyboard_shortcut: String # One that shows in game
@export var action_event: StringName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon.texture = icon
	$Icon.custom_minimum_size = Vector2(min_size, min_size)
	$Use.set_text(str(initial_value))
	
	if not has_use_button:
		$Button.disabled = true
		$Button.visible = false
		$VSeparator.visible = false
	else:
		var new_shortcut := Shortcut.new()
		var new_action := InputEventAction.new()
		new_action.action = action_event
		new_shortcut.events = [new_action]
		print(action_event)
		$Button.shortcut = new_shortcut
		$Button.text = "Use [" + keyboard_shortcut + "]"

func update_label(data: int) -> void:
	$Use.set_text(str(data))
