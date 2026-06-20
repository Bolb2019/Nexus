extends CharacterBody2D

const ACCELERATION = 18
const FRICTION = 5
const TURN_ACCELERATION = 0.055

func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	print("y:" + str(direction.x))
	print("x:" + str(direction.y))
	
	if (Input.is_action_pressed("Forward")):
		velocity += direction * ACCELERATION
	
	if (velocity.x >= 0):
		velocity.x -=  FRICTION
	elif (velocity.x <= 0):
		velocity.x += FRICTION
	if (velocity.y <= 0):
		velocity.y += FRICTION
	elif (velocity.y >= 0):
		velocity.y -=  FRICTION
		
	if (Input.is_action_pressed("Turn_Left")):
		rotation -= TURN_ACCELERATION
	elif (Input.is_action_pressed("Turn_Right")):
		rotation += TURN_ACCELERATION
		
	move_and_slide()
