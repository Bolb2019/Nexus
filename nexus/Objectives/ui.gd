extends Control

const LeaderboardItem = preload("res://Objectives/leaderboard_item.tscn")

@export var player: Player
@export var players: Dictionary[int, Player]

var leaderboard_items: Dictionary[int, Control] = {}

func _ready() -> void:
	%Label.player = player
	%Mobile.visible = OS.has_feature("mobile")
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


func _on_up_button_down() -> void:
	Input.action_press("Forward")


func _on_up_button_up() -> void:
	Input.action_release("Forward")


func _on_down_button_down() -> void:
	Input.action_press("Backward")


func _on_down_button_up() -> void:
	Input.action_release("Backward")


func _on_left_button_down() -> void:
	Input.action_press("Turn_Left")


func _on_left_button_up() -> void:
	Input.action_release("Turn_Left")


func _on_right_button_down() -> void:
	Input.action_press("Turn_Right")


func _on_right_button_up() -> void:
	Input.action_release("Turn_Right")


func _on_button_pressed() -> void:
	SceneManager.change_to_scene("menu")
