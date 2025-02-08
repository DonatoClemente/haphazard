extends Node2D

@onready var light: PointLight2D = $PointLight2D  # Reference to your Light2D node
@export var base_energy: float = 1.0    # Base light intensity
@export var flicker_speed: float = 10.0    # How fast the light can change
@export var min_flicker_time: float = 0.4  # Minimum time between flickers
@export var max_flicker_time: float = 1.0  # Maximum time between flickers

var current_energy: float = 1.0
var target_energy: float = 1.0
var time_elapsed: float = 0.0
var is_light_on: bool = true
var next_flicker_time: float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_energy = base_energy
	target_energy = base_energy
	next_flicker_time = randf_range(min_flicker_time, max_flicker_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	
	# Flicker at random intervals
	if time_elapsed >= next_flicker_time:
		time_elapsed = 0.0
		is_light_on = !is_light_on
		target_energy = base_energy if is_light_on else 0.0
		# Set next random flicker time
		next_flicker_time = randf_range(min_flicker_time, max_flicker_time)
		print("Light energy: ", target_energy, " Next flicker in: ", next_flicker_time)
	
	# Increased flicker_speed for faster transitions
	current_energy = lerp(current_energy, target_energy, flicker_speed * delta)
	
	light.energy = current_energy
