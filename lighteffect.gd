extends Node2D

@onready var light: PointLight2D = $PointLight2D 
@export var base_energy: float = 1.0 
@export var flicker_speed: float = 10.0  
@export var min_flicker_time: float = 0.4 
@export var max_flicker_time: float = 1.0

var current_energy: float = 1.0
var target_energy: float = 1.0
var time_elapsed: float = 0.0
var is_light_on: bool = true
var next_flicker_time: float = 0.2

func _ready() -> void:
	current_energy = base_energy
	target_energy = base_energy
	next_flicker_time = randf_range(min_flicker_time, max_flicker_time)

func _process(delta: float) -> void:
	time_elapsed += delta
	
	if time_elapsed >= next_flicker_time:
		time_elapsed = 0.0
		is_light_on = !is_light_on
		target_energy = base_energy if is_light_on else 0.0
		next_flicker_time = randf_range(min_flicker_time, max_flicker_time)
		print("Light energy: ", target_energy, " Next flicker in: ", next_flicker_time)
		
	current_energy = lerp(current_energy, target_energy, flicker_speed * delta)
	
	light.energy = current_energy
