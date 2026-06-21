extends Control

var times_pressed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Foucs.scale = Vector2(30, 30)
	$CanvasLayer/Foucs.position.x = 1450


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_yes_pressed() -> void:
	times_pressed += 1
	if times_pressed == 1:
		$CanvasLayer/Foucs.scale = Vector2(5.051, 5.051)
		$CanvasLayer/Foucs.position.x = 450.0
	if times_pressed == 2:
		$CanvasLayer/Foucs.scale = Vector2(5.051, 5.051)
		$CanvasLayer/Foucs.position.x = 558.0
	if times_pressed == 3:
		$CanvasLayer/Foucs.scale = Vector2(5.051, 5.051)
		$CanvasLayer/Foucs.position.x = 666.0
