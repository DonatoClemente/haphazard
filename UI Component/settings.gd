extends CanvasLayer

@onready var homemenu_scene = load("res://Scenes/HomeMenu.tscn")

func _ready() -> void:
	hide()
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): 
		if visible:
			unpause()
		else:
			pause()

func pause():
	show()
	get_tree().paused = true

func unpause():
	hide()
	get_tree().paused = false

func _on_button_pressed() -> void:
	unpause()
	get_tree().change_scene_to_packed(homemenu_scene)


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif index == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_entrance_prompt_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
