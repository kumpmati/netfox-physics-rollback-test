class_name Ball
extends NetworkRigidBody3D

var _forces := _HistoryBuffer.new()

func _physics_rollback_tick(_delta: float, tick: int) -> void:
	if Input.is_action_pressed("jump"):
		apply_central_force(Vector3.LEFT * 1000.0 * _delta)
	
	if _forces.has(tick):
		var motion: Vector3 = _forces.get_snapshot(tick)
		apply_central_impulse(motion)

func impulse(tick: int, motion: Vector3) -> void:
	_forces.set_snapshot(tick, motion)
