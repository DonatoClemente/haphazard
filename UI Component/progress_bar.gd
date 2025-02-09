extends ProgressBar

@export var status_sprite: Sprite2D

# Add these variables for the textures
@export var normal_texture: Texture2D
@export var empty_texture: Texture2D

func _ready():
	# Verify that the Sprite2D node exists
	if !status_sprite:
		push_error("Sprite2D node not found! Make sure you have added a Sprite2D node as a child of the ProgressBar.")
		return
		
	# Set up the initial size
	adjust_progress_bar_size()
	# Connect to window resize signal
	get_tree().root.connect("size_changed", adjust_progress_bar_size)
	# Connect to the value_changed signal
	connect("value_changed", _on_value_changed)

func adjust_progress_bar_size():
	# Get the window size
	var window_size = get_viewport_rect().size
	# Set the progress bar width to half the window width
	custom_minimum_size.x = window_size.x / 2

func _on_value_changed(new_value: float) -> void:
	if !status_sprite:
		return
		
	if new_value <= 0:
		status_sprite.texture = empty_texture
	else:
		status_sprite.texture = normal_texture
