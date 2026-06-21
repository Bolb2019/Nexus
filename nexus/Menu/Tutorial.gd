extends Control

var times_pressed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decide_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_yes_pressed() -> void:
	times_pressed += 1
	decide_text()

func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func decide_text():
	if times_pressed == 0:
		$CanvasLayer/Node/Slide0.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Welcome, do you want a tutorial?"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 1:
		$CanvasLayer/Node/Slide0.visible = true
		$CanvasLayer/Label.visible_characters = 0
		$CanvasLayer/Label.text = "Ok, just click no to stop the tutorial."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 2:
		$CanvasLayer/Node/Slide1.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Clicking this takes you to where you can host a server."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 3:
		$CanvasLayer/Node/Slide2.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "This is the server page where a host can start a server."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 4:
		$CanvasLayer/Node/Slide3.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "The host can set their name here."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 5:
		$CanvasLayer/Node/Slide4.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Add once all players have join they can start the game here."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 6:
		$CanvasLayer/Node/Slide5.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "This takes you back to the main menu."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 7:
		$CanvasLayer/Node/Slide6.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "And now this takes you to where you can join a server."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 8:
		$CanvasLayer/Node/Slide7.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "This is the join page!"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 9:
		$CanvasLayer/Node/Slide8.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "whoever is joining can set their name here."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 10:
		$CanvasLayer/Node/Slide9.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "Now for here, the player joining has to input the hosts IP adress."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 11:
		$CanvasLayer/Node/Slide10.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "aftering inputting the IP, click here to join the server."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 12:
		$CanvasLayer/Node/Slide11.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "This button also returns you to the main menu."
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout
			
	if times_pressed == 13:
		$CanvasLayer/Node/SlideLast.visible = true
		$CanvasLayer/Label.visible_ratio = 0
		$CanvasLayer/Label.text = "And this button closes the game! have fun!!"
		while $CanvasLayer/Label.visible_ratio < 1:
			$CanvasLayer/Label.visible_ratio += 0.1
			await get_tree().create_timer(0.1).timeout

	if times_pressed == 14:
		get_tree().change_scene_to_file("res://Menu/menu.tscn")
