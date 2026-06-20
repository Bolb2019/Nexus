extends CharacterBody2D

const ACCELERATION = 10
const FRICTION = 25
const TURN_ACCELERATION = 0.055

func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	print("y:" + str(direction.x))
	print("x:" + str(direction.y))
	
	if (Input.is_action_pressed("Forward")):
		velocity += direction * ACCELERATION
	elif (velocity.x >= abs(direction.x)):
		velocity.x -= direction.x * FRICTION
	elif (velocity.y >= abs(direction.y)):
		velocity.y -= direction.y * FRICTION
		
	if (Input.is_action_pressed("Turn_Left")):
		rotation -= TURN_ACCELERATION
	elif (Input.is_action_pressed("Turn_Right")):
		rotation += TURN_ACCELERATION
		
	move_and_slide()
