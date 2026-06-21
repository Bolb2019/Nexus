extends CharacterBody2D
class_name Player

const MAX_SPEED = 1300
const ACCELERATION = 18
const FRICTION = 5
const TURN_SPEED = 15

var turn_acell = 0.055
var powerslide = false

var controlled = true

# id and score only valid on non-controlled players
var id: int
var score := 0

func _physics_process(delta: float) -> void:
	if controlled:
		scale = Vector2(1 + float(GlobalStats.score / 100.0), 1 + float(GlobalStats.score / 100.0))*1.5
		
		var direction := Vector2.RIGHT.rotated(rotation)
		
		if (Input.is_action_pressed("Forward") and abs(velocity.x + velocity.y) <= MAX_SPEED):
			velocity += direction * ACCELERATION
			powerslide = false
		elif (Input.is_action_pressed("Backward") and abs(velocity.x + velocity.y) <= MAX_SPEED):
			velocity -= direction * ACCELERATION/2
			powerslide = false
		else:
			powerslide = true
		
		if (velocity.x >= 0):
			velocity.x -=  FRICTION
		elif (velocity.x <= 0):
			velocity.x += FRICTION
		if (velocity.y <= 0):
			velocity.y += FRICTION
		elif (velocity.y >= 0):
			velocity.y -=  FRICTION
		
		turn_acell = 0.03 + (MAX_SPEED - abs(velocity.y + velocity.x)) / (MAX_SPEED * TURN_SPEED)
		
		var modded_turn_accel = turn_acell
		if (powerslide and turn_acell <= 1):
			if (turn_acell <= 0.05):
				modded_turn_accel *= 2
			else:
				modded_turn_accel *= 1.5
		
		if (Input.is_action_pressed("Turn_Left")):
			rotation -= modded_turn_accel
		elif (Input.is_action_pressed("Turn_Right")):
			rotation += modded_turn_accel

	move_and_slide()
	
	if controlled:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider is Player and collider.score < GlobalStats.score:
				Lobby.update_score.rpc(collider.id, collider.score-1)

func _process(_delta: float) -> void:
	if controlled:
		var data = { "velocity": velocity, "position": position, "rotation": rotation }
		Lobby.update_data.rpc(multiplayer.get_unique_id(), data)
