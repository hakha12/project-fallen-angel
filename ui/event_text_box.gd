class_name EventText
extends Control

signal event_finished(current_night: int)

var visible_character_index: int = 0

@onready var events: Array[RichTextLabel] = [
	$Day0Text,
	$Day1Text
]

func _ready() -> void:
	for event in events:
		event.visible_characters = 0

func process_text(current_night: int) -> void:
	while visible_character_index < events[current_night].text.length():
		var current_char = events[current_night].text[visible_character_index]
		
		#$KeyboardSound.play()
		
		if current_char == ",":
			await get_tree().create_timer(0.0625).timeout
		elif current_char == ".":
			await get_tree().create_timer(0.125).timeout
		else:
			await get_tree().create_timer(0.02).timeout  # Normal typing speed
	
		visible_character_index += 1
		events[current_night].visible_characters = visible_character_index
	
	await get_tree().create_timer(0.4).timeout
	
	event_finished.emit()
	events[current_night].hide()
	visible_character_index = 0

func _on_event_started(current_night: int) -> void:
	if current_night > events.size() - 1:
		event_finished.emit()
		return
	events[current_night].show()
	process_text(current_night)
