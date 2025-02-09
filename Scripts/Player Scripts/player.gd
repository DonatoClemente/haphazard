extends CharacterBody2D

@export var speed: float = 69.0  # Maximum movement speed
@export var acceleration: float = 600.0  # How fast the player accelerates
@export var friction: float = 520.0  # How fast the player decelerates

@onready var anim = $AnimatedSprite2D  # Reference to AnimatedSprite2D
@onready var flashlight = $Flashlight # Reference to flashlight
@onready var hand: Sprite2D = $Flashlight/Hand

@export var flashlight_toggle: bool = false

@onready var Key: bool  = false
@onready var Gas: bool  = false
@onready var Oil: bool  = false
@onready var Lever: bool  = false
@onready var Generator: bool  = true

@onready var WALKING_AUDIO: AudioStreamPlayer2D = $WALKING_AUDIO

# Battery properties
var max_charge: int = 2250  # Maximum battery charge
var current_charge: int = 2250  # Current battery charge
var is_draining: bool = false  # Whether the battery is being used
@export var progress_bar: ProgressBar

func _ready() -> void:
	add_to_group("player")
	progress_bar.max_value = max_charge
	progress_bar.value = max_charge
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
	handle_flashlight(delta)
	
	
func _process(delta: float) -> void:
	handle_animation()

func handle_animation():
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):  # Moving left/right
			$AnimationPlayer.play("x")
			#anim.play("side")
			anim.flip_h = velocity.x < 0  # Flip for left movement
			hand.flip_h = velocity.x < 0  # Flip for left movement
			if velocity.x < 0 and $Sprites.scale.x > 0:
				$Sprites.scale.x *= -1  # Normal
			elif velocity.x > 0 and $Sprites.scale.x < 0:
				$Sprites.scale.x *= -1 # Flipped
		elif velocity.y > 0:  # Moving down
			#anim.play("down")
			$AnimationPlayer.play("down")
		else:  # Moving up
			#anim.play("up")
			$AnimationPlayer.play("up")
			
		if not WALKING_AUDIO.playing:
			WALKING_AUDIO.play()
	else:
		$AnimationPlayer.play("RESET")
		WALKING_AUDIO.stop()
		#anim.stop()  # Stops animation when idle
		
func handle_flashlight(delta):
	if current_charge <= 0 and flashlight_toggle:
		flashlight.flashlight_off()
		flashlight_toggle = false
		hand.visible = false
		set_active(false)
		
	if current_charge <= 0:
		pass		
		
		
	if flashlight_toggle:
		drain_battery(delta)
		

	
	if current_charge > 0 and Input.is_action_just_pressed("flashlight_toggle") and !flashlight_toggle:
		flashlight.flashlight_on()
		flashlight_toggle = true
		hand.visible = true
		set_active(true)
		
	elif Input.is_action_just_pressed("flashlight_toggle") and flashlight_toggle:
		flashlight.flashlight_off()
		flashlight_toggle = false
		hand.visible = false
		set_active(false)
		
# Function to drain battery gradually
func drain_battery(delta):
	current_charge -= delta
	progress_bar.value = current_charge
	current_charge = max(current_charge, 0)  # Ensure it doesn't go below 0
	if current_charge <= 0:
		flashlight.flashlight_off()
		flashlight_toggle = false
		set_active(false)

# Function to recharge the battery (if needed)
func recharge(amount: int):
	current_charge += amount
	current_charge = min(current_charge, max_charge)  # Ensure it doesn't exceed max charge

# Function to toggle battery usage
func set_active(state: bool):
	is_draining = state
