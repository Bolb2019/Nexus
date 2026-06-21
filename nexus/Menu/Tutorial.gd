extends Control

var times_pressed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalStats.tutorial:
		queue_free()
	decide_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_yes_pressed() -> void:
	times_pressed += 1
	decide_text()


func _on_no_pressed() -> void:
	self.queue_free()
	GlobalStats.tutorial = false

func decide_text():
	if times_pressed == 0:
		
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Welcome, do you want a tutorial?"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 1:
		$CanvasLayer/Node/Slide1.visible = true
		$CanvasLayer/Label.visible_characters = 0
		$CanvasLayer/Label.text = "Ok, just click no to stop the tutorial"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 2:
		$CanvasLayer/Node/Slide2.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Clicking this takes you to where you can host a server"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 3:
		$CanvasLayer/Node/Slide3.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Clicking this takes you to where you can host a server"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
