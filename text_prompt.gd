extends Area2D

@export_multiline var prompt_text: String = "Enter your prompt text here"
var has_been_triggered: bool = false
var player_in_range: bool = false
@export var display: CanvasLayer

func _ready() -> void:
	display.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not has_been_triggered:
		player_in_range = true
		display.story_text = prompt_text
		get_tree().paused = true
		has_been_triggered = true

func _process(_delta: float) -> void:
	if has_been_triggered and not display.visible:
		get_tree().paused = false
		has_been_triggered = false
		queue_free()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
