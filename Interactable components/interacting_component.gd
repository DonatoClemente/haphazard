extends Node2D

@onready var interact_label: Label = $InteractLabel
var current_interactions := []
var can_interact := true
var is_fading_in: bool = false

func _ready():
	interact_label.modulate.a = 0  # Start invisible
	is_fading_in = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			is_fading_in = false
			
			await current_interactions[0].interact.call()
			
			can_interact = true

func _process(delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(sort_by_closest)
		if current_interactions[0].is_interactable:
			if current_interactions[0].interact_name == "":
				interact_label.text = "Press [E]"
			else:
				interact_label.text = current_interactions[0].interact_name
				
			if !is_fading_in:
				fade_in()
	else:
		fade_out()

func sort_by_closest(area1, area2):
	var area1_dist = global_position.direction_to(area1.global_position)
	var area2_dist = global_position.direction_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)


func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)

func fade_in():
	var tween = get_tree().create_tween()
	interact_label.show()
	interact_label.modulate.a = 0
	tween.tween_property(interact_label, "modulate:a", 1.0, 0.2)  # Fade in over 0.5s
	is_fading_in = true
	await tween.finished
	tween.kill()
	
	
func fade_out():
	var tween = get_tree().create_tween()
	interact_label.modulate.a = 1
	tween.tween_property(interact_label, "modulate:a", 0.0, 0.15)  # Fade in over 0.5s
	is_fading_in = false
	await tween.finished
	tween.kill()
	
