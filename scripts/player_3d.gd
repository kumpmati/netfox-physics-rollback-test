class_name Player
extends CharacterBody3D

var peer_id: int

var log := _NetfoxLogger.for_netfox("Player")

@onready var input: PlayerInput = $Input
@onready var rollback_synchronizer: RollbackSynchronizer = $RollbackSynchronizer

func _ready() -> void:
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(int(name))


func _rollback_tick(_delta: float, _tick: int, _is_fresh: bool) -> void:
	velocity += input.move_wish_dir * 1000.0 * _delta
	
	if not is_on_floor():
		velocity.y -= 100.0 * _delta
	
	velocity /= NetworkTime.physics_factor
	move_and_slide()
	velocity *= NetworkTime.physics_factor
