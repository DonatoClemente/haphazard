extends CanvasLayer

@onready var home_scene = load("res://Scenes/HomeMenu.tscn")
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	audio_player.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(home_scene)
	audio_player.stop()
