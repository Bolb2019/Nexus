extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Player/Label.visible = false
	%Player/Camera2D.position_smoothing_enabled = false

func _on_play_button_pressed() -> void:
	if !GlobalStats.tutorial:
		GlobalStats.score = 0
		%Player/Label.visible = true
		SceneManager.change_to_scene("client_lobby")

func _on_quit_button_pressed() -> void:
	if !GlobalStats.tutorial:
		get_tree().quit()

func _on_host_button_pressed() -> void:
	if !GlobalStats.tutorial:
		GlobalStats.score = 0
		%Player/Label.visible = true
		SceneManager.change_to_scene("server_lobby")
