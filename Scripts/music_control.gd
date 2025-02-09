extends Node2D

@onready var heart_beat_n_bass: AudioStreamPlayer = $"../Heart Beat n Bass"
@onready var animal_noises: AudioStreamPlayer = $"../Animal Noises"
@onready var droning_noise: AudioStreamPlayer = $"../Droning Noise"
@onready var escalating_noise: AudioStreamPlayer = $"../Escalating Noise"

@onready var player: CharacterBody2D = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heart_beat_n_bass.play()
	animal_noises.play()
	droning_noise.play()
	escalating_noise.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
