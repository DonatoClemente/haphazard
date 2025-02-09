extends Node2D

@onready var heart_beat_n_bass: AudioStreamPlayer = $"../Heart Beat n Bass"
@onready var animal_noises: AudioStreamPlayer = $"../Animal Noises"
@onready var droning_noise: AudioStreamPlayer = $"../Droning Noise"
@onready var escalating_noise: AudioStreamPlayer = $"../Escalating Noise"
@onready var roar: AudioStreamPlayer = $"../MONSTER RAWR xd"

@onready var player: CharacterBody2D = $"../Player"
@onready var monster: CharacterBody2D = $"../Monster"

var max_distance = 150  # The maximum distance at which volume changes
var monster_position: Vector3  # Set this to the monster's position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart_beat_n_bass.play()
	animal_noises.play()
	droning_noise.play()
	escalating_noise.play()
	heart_beat_n_bass.volume_db = -10
	droning_noise.volume_db = -20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance = player.global_transform.origin.distance_to(monster.position)
	var factor = clamp(1.0 - (distance / max_distance), 0.0, 1.0)
	heart_beat_n_bass.volume_db = lerp(-12, 10, factor)
	droning_noise.volume_db = lerp(-25, 0, factor)
	
	if distance < 50 and randf_range(0, 666) < 1 and !roar.playing:
		roar.play()

	
