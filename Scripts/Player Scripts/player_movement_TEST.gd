extends CharacterBody2D

@export var speed: float = 69.0  # Maximum movement speed
@export var acceleration: float = 600.0  # How fast the player accelerates
@export var friction: float = 520.0  # How fast the player decelerates

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Get input from WASD keys
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	# Normalize input vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()

	# Apply acceleration if there's input, otherwise apply friction
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	# Move the character
	move_and_slide()
