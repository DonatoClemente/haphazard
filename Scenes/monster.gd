extends CharacterBody2D


const SPEED = 20.0
const RUN_SPEED = 50.0
const RUN_ANIM_MULT = 3.0
@onready var nav_agent = $NavigationAgent2D
@export var player: CharacterBody2D

func _ready() -> void:
	nav_agent.target_position = player.global_position

func _physics_process(delta: float) -> void:
	var next_position = nav_agent.get_next_path_position()
	
	velocity = global_position.direction_to(player.global_position) * SPEED
	if velocity.length() > 0.1:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	
	move_and_slide()
