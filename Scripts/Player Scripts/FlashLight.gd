extends PointLight2D

var rotation_speed = 8.0  # Adjust to control the smoothness

func _process(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	var target_rotation = (get_global_mouse_position() - player.position).angle() - PI*.5
	#look_at(get_global_mouse_position())
	rotation = lerp_angle(rotation, target_rotation, delta * rotation_speed)
