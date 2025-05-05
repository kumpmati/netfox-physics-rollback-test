extends NetworkRigidBody2D

func _physics_rollback_tick(_delta: float, tick: int) -> void:
	if Input.is_action_pressed("jump"):
		apply_central_force(Vector2.UP * 100000.0 * _delta)
