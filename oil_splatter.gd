extends Sprite2D

@export var intractable: Area2D
@export var sprite_2d: Sprite2D
@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intractable.interact = _on_interact


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_interact():
	if player.Gas:
		player.Oil = true
		queue_free()
	pass
