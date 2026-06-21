extends Area2D

@export var id: int

var dying = false

signal eaten(id: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (dying and $CPUParticles2D.emitting == false):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.controlled:
		$CPUParticles2D.emitting = true
		$ColorRect.visible = false
		GlobalStats.score += 1
		Lobby.update_score.rpc(multiplayer.get_unique_id(), GlobalStats.score)
		Lobby.delete_cheese.rpc(id)
		eaten.emit(id)
		dying = true
