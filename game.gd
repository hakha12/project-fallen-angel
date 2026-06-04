extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level/Player.item_collected.connect($UI/ItemCounter._on_player_item_collected)
