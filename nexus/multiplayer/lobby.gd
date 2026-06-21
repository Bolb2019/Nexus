extends Node

const PORT = 23942

signal player_count_updated(players: int)
signal player_updated(id: int, data: Dictionary)
signal score_updated(id: int, score: int)
signal server_connected
signal server_connection_failed

## { "velocity": Vector2, "position": Vector2, "rotation": 0.0 }
## does not include self
var players: Dictionary[int, Dictionary] = {}

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_server_connected)
	multiplayer.connection_failed.connect(server_connection_failed.emit)

func host_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	_update_player_count()

func join_game(ip: String):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

func leave_game() -> void:
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	_update_player_count()

func _on_peer_connected(_id: int):
	_update_player_count()

func _on_peer_disconnected(id: int):
	players.erase(id)
	_update_player_count()

func _on_server_connected():
	server_connected.emit()
	_update_player_count()

func _update_player_count():
	var count = multiplayer.get_peers().size() + 1
	player_count_updated.emit(count)

@rpc("call_local")
func start_game():
	get_tree().change_scene_to_file("res://Main/Main.tscn")

@rpc("any_peer", "unreliable_ordered")
func update_data(id: int, data: Dictionary):
	players[id] = data
	player_updated.emit(id, data)

@rpc("any_peer")
func update_score(id: int, score: int):
	if players.has(id):
		players[id]["score"] = score
		score_updated.emit(id, score)
	elif id == multiplayer.get_unique_id():
		GlobalStats.score = score
