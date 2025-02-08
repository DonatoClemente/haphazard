extends Node

# Battery properties
var max_charge: int = 100  # Maximum battery charge
var current_charge: int = 100  # Current battery charge
var drain_rate: float = 1.0  # How much charge drains per second
var is_active: bool = false  # Whether the battery is being used

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		drain_battery(delta)

# Function to drain battery gradually
func drain_battery(delta):
	current_charge -= drain_rate * delta
	current_charge = max(current_charge, 0)  # Ensure it doesn't go below 0

# Function to recharge the battery (if needed)
func recharge(amount: int):
	current_charge += amount
	current_charge = min(current_charge, max_charge)  # Ensure it doesn't exceed max charge

# Function to toggle battery usage
func set_active(state: bool):
	is_active = state
