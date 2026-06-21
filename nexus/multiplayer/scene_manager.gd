extends Node

var scenes = {
	"menu": "res://Menu/menu.tscn",
	"client_lobby": "res://Menu/Lobby/client_lobby.tscn",
	"server_lobby": "res://Menu/Lobby/server_lobby.tscn",
	"main": "res://Main/Main.tscn"
}

func change_to_scene(scene: String):
	var tree = get_tree()
	if not tree:
		return
	tree.change_scene_to_file(scenes[scene])
