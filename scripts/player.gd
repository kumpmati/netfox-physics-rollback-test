class_name Player
extends CharacterBody3D

var peer_id: int

@onready var input: PlayerInput = $Input
@onready var rollback_synchronizer: RollbackSynchronizer = $RollbackSynchronizer

func _ready() -> void:
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(int(name))


func _rollback_tick(_delta: float, _tick: int, _is_fresh: bool) -> void:
	velocity += input.move_wish_dir * 100.0
	
	velocity /= NetworkTime.physics_factor
	move_and_slide()
	velocity *= NetworkTime.physics_factor
