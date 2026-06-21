extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Player/Label.visible = false
	%Player/Camera2D.position_smoothing_enabled = false

func _on_play_button_pressed() -> void:
	GlobalStats.score = 0
	%Player/Label.visible = true
	get_tree().change_scene_to_file("res://Menu/Lobby/client_lobby.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_host_button_pressed() -> void:
	GlobalStats.score = 0
	%Player/Label.visible = true
	get_tree().change_scene_to_file("res://Menu/Lobby/server_lobby.tscn")
