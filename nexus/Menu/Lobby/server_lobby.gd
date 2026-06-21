extends Control

func _ready() -> void:
	Lobby.host_game()
	%Name.text = Lobby.player_name
	%Name.text_changed.connect(Lobby.update_name)

func _on_exit_button_pressed() -> void:
	GlobalStats.score = 500
	Lobby.leave_game()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_play_button_pressed() -> void:
	Lobby.start_game.rpc($City.get_data())
