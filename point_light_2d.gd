extends PointLight2D

@export var intractable: Area2D
@export var player: CharacterBody2D
@onready var credit_scene = load("res://Scenes/Credits.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intractable.interact = _on_interact


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_interact():
	if player.Generator:
		get_tree().change_scene_to_packed(credit_scene)
