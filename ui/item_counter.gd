extends Control

var coin_counter :int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func collect_coin():
	coin_counter += 1
	
	$Container/Crystal/Use.set_text(str(coin_counter))

func purchase_item(item_type: int):
	pass

func _on_player_item_collected(item: RigidBody2D) -> void:
	if item is Crystal: collect_coin()
