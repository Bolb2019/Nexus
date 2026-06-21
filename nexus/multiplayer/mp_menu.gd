extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# server
func _on_button_pressed() -> void:
	print(Lobby.run_server())


# client
func _on_button_2_pressed() -> void:
	print(Lobby.run_client(%IP.text))


# start game
func _on_button_3_pressed() -> void:
	Lobby.start_game.rpc()
