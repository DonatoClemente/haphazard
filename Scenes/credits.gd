extends CanvasLayer

@onready var home_scene = load("res://Scenes/HomeMenu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(home_scene)
