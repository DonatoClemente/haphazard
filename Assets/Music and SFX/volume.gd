# volume_slider.gd
extends HSlider

@export
var bus_name: String = "Master"  # Set default to "Master"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	print("Bus name: ", bus_name)  # Debug print
	print("Bus index: ", bus_index)  # Debug print
	
	if bus_index < 0:
		push_error("Audio bus '" + bus_name + "' not found!")
		return
		
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float) -> void:
	if bus_index >= 0:  # Only adjust volume if we have a valid bus
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
