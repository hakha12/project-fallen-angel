class_name ItemCounter
extends HBoxContainer

@export var min_size: float = 48.0
@export var icon_texture: Texture2D
@export var initial_value: int = 0
@export var has_use_button: bool = true
@export var keyboard_shortcut: String # One that shows in game
@export var action_event: StringName

@onready var icon: TextureRect = $Icon
@onready var remaining_use: Label = $Use
@onready var button: Button = $Button
@onready var button_sound: AudioStreamPlayer2D = $ButtonSound
@onready var button_fail_sound: AudioStreamPlayer2D = $ButtonFailSound
@onready var not_enough: Label = $NotEnoughText
@onready var _separator: VSeparator = $VSeparator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.texture = icon_texture
	icon.custom_minimum_size = Vector2(min_size, min_size)
	remaining_use.set_text(str(initial_value))
	not_enough.hide()
	
	if not has_use_button:
		button.disabled = true
		button.visible = false
		_separator.visible = false
	else:
		var new_shortcut := Shortcut.new()
		var new_action := InputEventAction.new()
		new_action.action = action_event
		new_shortcut.events = [new_action]
		button.shortcut = new_shortcut
		button.text = "Use [" + keyboard_shortcut + "]"

func update_label(data: int) -> void:
	remaining_use.set_text(str(data))
