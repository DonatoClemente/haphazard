extends RichTextLabel

@onready var mat = $".".material  # Get the shader material

func _process(delta):
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("time", Time.get_ticks_msec() / 1000.0)
