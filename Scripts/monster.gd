extends CharacterBody2D

const speed_slow = 15
const speed_flast = 25

@onready var player: CharacterBody2D = $"../Player"
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position().normalized())
	print(nav_agent.get_next_path_position())
	velocity = dir * speed_slow
	move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	makepath()
