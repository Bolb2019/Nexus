extends Node2D

const MpPlayer = preload("res://multiplayer/mp_player.tscn")

var players = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_updated.connect(_on_player_updated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Lobby.update_player.rpc(%Player.position, %Player.rotation)


func _on_player_updated(id: int, pos: Vector2, rot: float):
	if players.has(id):
		var player = players[id]
		player.position = pos
		player.rotation = rot
	else:
		var player = MpPlayer.instantiate()
		player.can_move = false
		player.position = pos
		player.rotation = rot
		players[id] = player
		add_child(player)
