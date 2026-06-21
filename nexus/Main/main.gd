extends Node2D

const PlayerScene = preload("res://Player/Player.tscn")

var players: Dictionary[int, Player] = {}

func _ready() -> void:
	Lobby.player_updated.connect(_on_player_updated)
	Lobby.score_updated.connect(_on_score_updated)

func _on_player_updated(id: int, data: Dictionary):
	if id == multiplayer.get_unique_id():
		pass
	if players.has(id):
		var player = players[id]
		player.position = data["position"]
		player.rotation = data["rotation"]
		player.velocity = data["velocity"]
	else:
		var player = PlayerScene.instantiate()
		player.controlled = false
		player.id = id
		player.position = data["position"]
		player.rotation = data["rotation"]
		player.velocity = data["velocity"]
		players[id] = player
		add_child(player)

func _on_score_updated(id: int, score: int):
	print(id, " ", score)
	if players.has(id):
		var player = players[id]
		player.score = score
	else:
		var player = PlayerScene.instantiate()
		player.controlled = false
		player.id = id
		player.score = score
		players[id] = player
		add_child(player)
