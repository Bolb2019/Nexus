extends Node2D

const MAX_CHEESE = 200
const SPAWN_RANGE = 384*20

var time = 0
var wait_time = 0

var cheese_id := 1
var cheeses: Dictionary[int, Node2D] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.cheese_created.connect(_on_cheese_created)
	Lobby.cheese_deleted.connect(_on_cheese_deleted)
	
	if not multiplayer.is_server():
		return
	for i in MAX_CHEESE:
		genCheese()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not multiplayer.is_server():
		return
	
	time += delta
	
	if time > wait_time:
		wait_time += 1
		genCheese()
		genCheese()
		genCheese()

func genCheese():
	if get_child_count() >= MAX_CHEESE:
		return
		
	Lobby.create_cheese.rpc(cheese_id, Vector2(randi() % SPAWN_RANGE, randi() % SPAWN_RANGE))
	cheese_id += 1

func _on_cheese_created(id: int, pos: Vector2):
	var cheese = preload("res://Objectives/Objects/Cheese.tscn").instantiate()
	add_child(cheese)
	cheese.id = id
	cheese.global_position = pos
	cheese.eaten.connect(_on_cheese_eaten)
	cheeses[id] = cheese

func _on_cheese_eaten(id: int):
	cheeses.erase(id)

func _on_cheese_deleted(id: int):
	if cheeses.has(id):
		cheeses[id].queue_free()
		cheeses.erase(id)
