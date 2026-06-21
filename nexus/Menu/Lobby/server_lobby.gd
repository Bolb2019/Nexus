extends Control

func _ready() -> void:
	Lobby.host_game()
	%Name.text = Lobby.player_name
	%Name.text_changed.connect(Lobby.update_name)

func _on_exit_button_pressed() -> void:
	GlobalStats.score = 500
	Lobby.leave_game()
	SceneManager.change_to_scene("menu")

func _on_play_button_pressed() -> void:
	Lobby.start_game.rpc($City.get_data())


func _on_ip_pressed() -> void:
	$VBoxContainer/Label.show()
	$VBoxContainer/Label.text = "IP: " + str(get_local_ip())

func get_local_ip() -> String:
	for address in IP.get_local_addresses():
		if "." in address and not address.begins_with("127.") and not address.begins_with("169.254."):
			if address.begins_with("192.168.") or address.begins_with("10.") or (address.begins_with("172.") and int(address.split(".")[1]) >= 16 and int(address.split(".")[1]) <= 31):
				return address
	return "127.0.0.1"
