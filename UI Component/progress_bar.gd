extends ProgressBar

func _ready():
	# Set up the initial size
	adjust_progress_bar_size()
	# Connect to window resize signal
	get_tree().root.connect("size_changed", adjust_progress_bar_size)

func adjust_progress_bar_size():
	# Get the window size
	var window_size = get_viewport_rect().size
	# Set the progress bar width to half the window width
	custom_minimum_size.x = window_size.x / 2
