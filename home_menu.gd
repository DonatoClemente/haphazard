extends CanvasLayer

@onready var credit_scene = load("res://Scenes/Credits.tscn")
@onready var control_panel = $Options

@onready var audio_intro: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_loop: AudioStreamPlayer = $AudioStreamPlayer2


func _ready() -> void:
	if control_panel:
		control_panel.visible = false
	audio_intro.play()
	await audio_intro.finished
	audio_loop.play()
	
func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	control_panel.visible = true
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credit_scene)
	audio_intro.stop()
	audio_loop.stop()
	pass # Replace with function body.


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	control_panel.visible = false
