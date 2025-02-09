extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.9)
		$AnimationPlayer.play("RESET")
	
	if direction:
		if velocity.x != 0:
			$AnimationPlayer.play("x")
			if velocity.x < 0:
				$Sprites.set_scale(Vector2(-1,1))
			else:
				$Sprites.set_scale(Vector2(1,1))
		else:
			if velocity.y > 0:
				$AnimationPlayer.play("down")
			elif velocity.y < 0:
				$AnimationPlayer.play("up")

	move_and_slide()
