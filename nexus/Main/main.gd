extends Node2D

const PlayerScene = preload("res://Player/Player.tscn")

var players: Dictionary[int, Player] = {}

func _ready() -> void:
	Lobby.player_updated.connect(_on_player_updated)
	Lobby.score_updated.connect(_on_score_updated)
	Lobby.server_disconnected.connect(_on_disconnected)
	Lobby.player_left.connect(_on_player_left)
	Lobby.player_died.connect(_on_player_left)
	$Ui.players = players

func _process(_delta: float) -> void:
	if GlobalStats.score < 0:
		Lobby.report_dead.rpc()
		$Player.queue_free()

func _on_player_updated(id: int, data: Dictionary):
	if not multiplayer:
		return
	if id == multiplayer.get_unique_id():
		pass
	if players.has(id):
		var player = players[id]
		player.position = data["position"]
		player.rotation = data["rotation"]
		player.velocity = data["velocity"]
		player.player_name = data["name"]
	else:
		var player = PlayerScene.instantiate()
		player.controlled = false
		player.id = id
		player.position = data["position"]
		player.rotation = data["rotation"]
		player.velocity = data["velocity"]
		player.player_name = data["name"]
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

func _on_disconnected() -> void:
	Lobby.leave_game()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_player_left(id: int) -> void:
	if players.has(id):
		players[id].queue_free()
		players.erase(id)
	if players.is_empty():
		# TODO: win screen
		Lobby.report_win.rpc()
		get_tree().change_scene_to_file("res://Menu/menu.tscn")
