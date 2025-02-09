extends PointLight2D

var rotation_speed = 8.0  # Adjust to control the smoothness

var flashlight_texture = preload("res://Assets/Art/player_light_cone.png")
var default_texture = preload("res://Assets/Art/player_base_light.png")

# Start off with no flashlight on
func _ready() -> void:
	texture = default_texture

func _process(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	var target_rotation = (get_global_mouse_position() - player.position).angle() - PI*.5
	#look_at(get_global_mouse_position())
	rotation = lerp_angle(rotation, target_rotation, delta * rotation_speed)

func flashlight_on():
	texture = flashlight_texture
	
func flashlight_off():
	texture = default_texture
