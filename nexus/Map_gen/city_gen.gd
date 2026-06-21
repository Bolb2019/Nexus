extends Node2D

@export var city_width: int = 20
@export var city_height: int = 20

@export var cell_size: int = 334 + randi() % 100
@export var road_width: int = 108 + randi() % 40

@export var building_min_size: int = 54 + randi() % 20
@export var building_max_size: int = 108 + randi() % 40

@export var road_color: Color = Color(0.2, 0.2, 0.2)

@export var building_colors: Array[Color] = [
	Color(0.8, 0.8, 0.8),
	Color(0.7, 0.7, 0.75),
	Color(0.75, 0.7, 0.7),
	Color(0.6, 0.6, 0.65)
]

@export var boundary_building_min_size: int = 512
@export var boundary_building_max_size: int = 2048
@export var boundary_building_color: Color = Color(0.15, 0.15, 0.18)

var rng := RandomNumberGenerator.new()

var buildings: Array = []
var boundary_buildings: Array = []

func _ready():
	print("setting seed to ", Lobby.seed)
	rng.seed = Lobby.seed

	_generate_buildings()
	_generate_boundary_buildings()

	_create_building_collisions()
	_create_city_boundaries()

	queue_redraw()

func _draw():
	_draw_roads()
	_draw_boundary_buildings()
	_draw_buildings()

func _generate_buildings():
	buildings.clear()

	for x in range(city_width):
		for y in range(city_height):

			var origin = Vector2(x * cell_size, y * cell_size)

			var margin = road_width * 0.6

			var min_pos = origin + Vector2(margin, margin)
			var max_pos = origin + Vector2(cell_size - margin, cell_size - margin)

			var size = Vector2(
				rng.randi_range(building_min_size, building_max_size),
				rng.randi_range(building_min_size, building_max_size)
			)

			var pos = Vector2(
				rng.randf_range(min_pos.x, max_pos.x - size.x),
				rng.randf_range(min_pos.y, max_pos.y - size.y)
			)

			var color = building_colors[
				rng.randi_range(0, building_colors.size() - 1)
			]

			buildings.append({
				"rect": Rect2(pos, size),
				"color": color
			})

func _generate_boundary_buildings():
	boundary_buildings.clear()

	var total_width = city_width * cell_size
	var total_height = city_height * cell_size

	var spacing = 256

	# Top
	for x in range(-2048, total_width + 2048, spacing):

		var depth = rng.randi_range(
			boundary_building_min_size,
			boundary_building_max_size
		)

		boundary_buildings.append(
			Rect2(
				x,
				-depth,
				spacing,
				depth
			)
		)

	# Bottom
	for x in range(-2048, total_width + 2048, spacing):

		var depth = rng.randi_range(
			boundary_building_min_size,
			boundary_building_max_size
		)

		boundary_buildings.append(
			Rect2(
				x,
				total_height,
				spacing,
				depth
			)
		)

	# Left
	for y in range(-2048, total_height + 2048, spacing):

		var depth = rng.randi_range(
			boundary_building_min_size,
			boundary_building_max_size
		)

		boundary_buildings.append(
			Rect2(
				-depth,
				y,
				depth,
				spacing
			)
		)

	# Right
	for y in range(-2048, total_height + 2048, spacing):

		var depth = rng.randi_range(
			boundary_building_min_size,
			boundary_building_max_size
		)

		boundary_buildings.append(
			Rect2(
				total_width,
				y,
				depth,
				spacing
			)
		)

func _draw_roads():
	var total_width = city_width * cell_size
	var total_height = city_height * cell_size

	for x in range(city_width + 1):
		var px = x * cell_size

		draw_rect(
			Rect2(
				Vector2(px - road_width / 2, 0),
				Vector2(road_width, total_height)
			),
			road_color
		)

	for y in range(city_height + 1):
		var py = y * cell_size

		draw_rect(
			Rect2(
				Vector2(0, py - road_width / 2),
				Vector2(total_width, road_width)
			),
			road_color
		)

func _draw_buildings():
	for building in buildings:
		draw_rect(building.rect, building.color)

func _draw_boundary_buildings():
	for rect in boundary_buildings:
		draw_rect(rect, boundary_building_color)

func _create_building_collisions():
	for building in buildings:

		var rect: Rect2 = building.rect

		var body := StaticBody2D.new()
		add_child(body)

		var collision := CollisionShape2D.new()
		body.add_child(collision)

		var shape := RectangleShape2D.new()
		shape.size = rect.size

		collision.shape = shape
		collision.position = rect.position + rect.size * 0.5

func _create_city_boundaries():

	var total_width = city_width * cell_size
	var total_height = city_height * cell_size

	var wall_thickness = 256.0

	_create_wall(
		Vector2(total_width * 0.5, -wall_thickness * 0.5),
		Vector2(total_width, wall_thickness)
	)

	_create_wall(
		Vector2(total_width * 0.5, total_height + wall_thickness * 0.5),
		Vector2(total_width, wall_thickness)
	)

	_create_wall(
		Vector2(-wall_thickness * 0.5, total_height * 0.5),
		Vector2(wall_thickness, total_height)
	)

	_create_wall(
		Vector2(total_width + wall_thickness * 0.5, total_height * 0.5),
		Vector2(wall_thickness, total_height)
	)

func _create_wall(center: Vector2, size: Vector2):

	var body := StaticBody2D.new()
	add_child(body)

	var collision := CollisionShape2D.new()
	body.add_child(collision)

	var shape := RectangleShape2D.new()
	shape.size = size

	collision.shape = shape
	collision.position = center
