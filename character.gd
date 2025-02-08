extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var WALKING_AUDIO: AudioStreamPlayer2D = $WALKING_AUDIO
@onready var walk_timer: Timer = $WalkerTimer

var is_moving := false

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("ui_left", "ui_right")
	var vertical := -Input.get_axis("ui_down", "ui_up")
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(-velocity.y, 0, SPEED)

	if horizontal or vertical:
		is_moving = true
		if not WALKING_AUDIO.playing:
			WALKING_AUDIO.play()
		walk_timer.stop()  # Reset the timer while moving
	else:
		if is_moving:
			is_moving = false
			walk_timer.start()  # Start the 1-second countdown

	move_and_slide()

func _on_walker_timer_timeout() -> void:
	WALKING_AUDIO.stop()
