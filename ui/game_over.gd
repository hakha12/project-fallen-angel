class_name GameOver
extends Control

signal game_reset

@onready var restart_button: Button = $Container/RestartButton
@onready var title_button: Button = $Container/MainMenuButton
@onready var night_survived: Label = $Container/NightSurvived
@onready var kill_count: Label = $Container/KillCount

func _ready() -> void:
	var new_shortcut := Shortcut.new()
	var new_action := InputEventAction.new()
	new_action.action = &"ui_accept"
	new_shortcut.events = [new_action]
	restart_button.shortcut = new_shortcut
	
	var title_shortcut := Shortcut.new()
	var title_action := InputEventAction.new()
	title_action.action = &"ui_go_title"
	title_shortcut.events = [title_action]
	title_button.shortcut = title_shortcut	

func _on_game_over(night_count: int, enemy_killed: int) -> void:
	night_survived.set_text("Night Survived: " + str(night_count))
	kill_count.set_text("Enemy Killed: " + str(enemy_killed))
	show()

func _on_restart_button_pressed() -> void:
	game_reset.emit()
	hide()


func _on_main_menu_button_pressed() -> void:
	var title: PackedScene = load("res://title_screen.tscn")
	var title_scene: Node = title.instantiate()
	var old: Node = get_tree().current_scene
	get_tree().root.add_child(title_scene)
	get_tree().current_scene = title_scene
	old.queue_free()
