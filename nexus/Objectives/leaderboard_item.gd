extends HBoxContainer

@export var player_name: String:
	set(new_name):
		player_name = new_name
		if name_label:
			name_label.text = player_name

@export var score: int:
	set(new_score):
		score = new_score
		if score_label:
			score_label.text = str(score)

@export var name_label: Label
@export var score_label: Label


func _ready() -> void:
	name_label.text = player_name
	score_label.text = str(score)
