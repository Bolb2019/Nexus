extends Control

func _ready() -> void:
	Lobby.host_game()

func _on_exit_button_pressed() -> void:
	Lobby.leave_game()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_play_button_pressed() -> void:
	Lobby.start_game.rpc()
