extends Control

const LeaderboardItem = preload("res://Objectives/leaderboard_item.tscn")

@export var player: Player
@export var players: Dictionary[int, Player]

var leaderboard_items: Dictionary[int, Control] = {}

func _ready() -> void:
	%Label.player = player
	Lobby.server_disconnected.connect(_on_game_over)

func _process(_delta: float) -> void:
	for id in leaderboard_items.keys():
		if not players.has(id):
			leaderboard_items[id].queue_free()
			leaderboard_items.erase(id)
	for id in players:
		if leaderboard_items.has(id):
			leaderboard_items[id].player_name = players[id].player_name
			leaderboard_items[id].score = players[id].score
		else:
			var item = LeaderboardItem.instantiate()
			item.player_name = players[id].player_name
			item.score = players[id].score
			leaderboard_items[id] = item
			%Leaderboard.add_child(item)
	var id = multiplayer.get_unique_id()
	if leaderboard_items.has(id):
		leaderboard_items[id].player_name = Lobby.player_name
		leaderboard_items[id].score = GlobalStats.score
	else:
		var item = LeaderboardItem.instantiate()
		item.player_name = Lobby.player_name
		item.score = GlobalStats.score
		leaderboard_items[id] = item
		%Leaderboard.add_child(item)
	var items = %Leaderboard.get_children()
	items.sort_custom(func(a, b): return a.score > b.score)
	for i in items.size():
		%Leaderboard.move_child(items[i], i)

func _on_game_over():
	for item in leaderboard_items.values():
		item.queue_free()
	leaderboard_items.clear()
