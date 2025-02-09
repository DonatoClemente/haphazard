extends Sprite2D


@onready var interactable: Area2D = $Interactable

func _ready() -> void:
	interactable.interact = on_interact
	
func on_interact():
	print("I INTERACTED WITH SOMETHING")
