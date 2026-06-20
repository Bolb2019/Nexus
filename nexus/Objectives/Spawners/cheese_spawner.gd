extends Node2D

const MAX_CHEESE = 200

var time = 0
var wait_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while (get_child_count() < MAX_CHEESE):
		genCheese()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	
	if time > wait_time:
		wait_time += 1
		genCheese()
		genCheese()
		genCheese()

func genCheese():
	if get_child_count() >= MAX_CHEESE:
		return
		
	var cheese = preload("res://Objectives/Objects/Cheese.tscn").instantiate()
	add_child(cheese)
	cheese.global_position =  Vector2(randi() % 3000, randi() % 3000)
