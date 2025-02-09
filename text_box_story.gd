extends CanvasLayer

@onready var text_display: RichTextLabel = $RichTextLabel
@export_multiline var story_text: String = "Enter Script":
	set(value):
		story_text = value
		# Reset all variables when text changes
		display_index = 0
		batch_start = 0
		is_batch_complete = false
		text_display.text = ""
		show()  # Show the text prompt

@export var chars_per_batch: int = 100
@export var display_speed: float = 0.05
var display_timer: float = 0
var display_index: int = 0
var batch_start: int = 0
var is_batch_complete: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_display.text = ""
	text_display.scroll_active = false
	hide()  # Hide initially

func _process(delta: float) -> void:
	if not is_batch_complete and display_index < min(batch_start + chars_per_batch, story_text.length()):
		display_timer += delta
		if display_timer >= display_speed:
			display_timer = 0
			text_display.text += story_text[display_index]
			display_index += 1
			
			if display_index >= min(batch_start + chars_per_batch, story_text.length()):
				is_batch_complete = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if not is_batch_complete:
			# Complete current batch instantly
			while display_index < min(batch_start + chars_per_batch, story_text.length()):
				text_display.text += story_text[display_index]
				display_index += 1
			is_batch_complete = true
		else:  # Batch is complete, move to next batch
			if display_index >= story_text.length():
				hide()  # Hide the prompt when done
				return
				
			text_display.text = ""  # Clear the previous batch
			batch_start = display_index
			is_batch_complete = false
