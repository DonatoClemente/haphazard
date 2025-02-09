extends CanvasLayer

@onready var homemenu_scene = load("res://Scenes/HomeMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the menu initially
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):  # ESC key
		if visible:
			hide()
		else:
			show()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(homemenu_scene)
