extends NetworkRigidBody3D

func _physics_rollback_tick(_delta: float, _tick: int) -> void:
	if Input.is_action_pressed("jump"):
		apply_central_impulse(Vector3.UP * 1.0)
