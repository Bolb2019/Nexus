extends Node

const PORT = 13948
const MAX_CONNECTIONS = 10

signal player_updated(id: int, position: Vector2, rotation: float)

func run_server():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

func run_client(server_ip: String):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_ip, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

## called by server to start game
@rpc("call_local", "reliable")
func start_game():
	get_tree().change_scene_to_file("res://multiplayer/mp_poc.tscn")

## called by client to all peers when updated
@rpc("call_remote", "unreliable_ordered")
func update_player(position: Vector2, rotation: float):
	player_updated.emit(multiplayer.get_remote_sender_id(), position, rotation)
