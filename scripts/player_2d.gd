class_name Player2D
extends CharacterBody2D

var peer_id: int

var log := _NetfoxLogger.for_netfox("Player2D")

@onready var input: PlayerInput2D = $Input
@onready var rollback_synchronizer: RollbackSynchronizer = $RollbackSynchronizer

func _ready() -> void:
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(int(name))


func _rollback_tick(_delta: float, _tick: int, _is_fresh: bool) -> void:
	velocity += input.move_wish_dir * 100000.0 * _delta
	
	velocity /= NetworkTime.physics_factor
	move_and_slide()
	velocity *= NetworkTime.physics_factor
