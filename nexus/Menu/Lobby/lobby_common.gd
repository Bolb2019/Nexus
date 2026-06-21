extends Control

func _ready() -> void:
	Lobby.player_count_updated.connect(_update_player_count)

func _update_player_count(count: int) -> void:
	%PlayerCount.text = str(count)
