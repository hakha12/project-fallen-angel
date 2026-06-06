class_name StoreCounter
extends VBoxContainer

@export var item_name: String
@export var min_size: float = 48.0
@export var icon_texture: Texture2D
@export var price: int = 0

@onready var label: Label = $Label
@onready var icon: TextureRect = $Icon
@onready var button: Button = $Button
@onready var button_sound: AudioStreamPlayer2D = $ButtonSound
@onready var button_fail_sound: AudioStreamPlayer2D = $ButtonFailSound
@onready var not_enough: Label = $NotEnoughText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.set_text(item_name)
	icon.texture = icon_texture
	icon.custom_minimum_size = Vector2(min_size, min_size)
	button.set_text("Buy\n" + str(price))
	not_enough.hide()
