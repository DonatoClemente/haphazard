extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_material.sub_emitter_amount_at_end = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
