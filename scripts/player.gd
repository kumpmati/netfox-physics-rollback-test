class_name Player
extends CharacterBody3D

var peer_id: int

var log := _NetfoxLogger.for_netfox("Player")

@onready var area_3d: Area3D = $Area3D
@onready var input: PlayerInput = $Input
@onready var rollback_synchronizer: RollbackSynchronizer = $RollbackSynchronizer

func _ready() -> void:
	set_multiplayer_authority(1)
	input.set_multiplayer_authority(int(name))


func _rollback_tick(_delta: float, _tick: int, _is_fresh: bool) -> void:
	velocity += input.move_wish_dir * 1000.0 * _delta
	
	if not is_on_floor():
		velocity.y -= 100.0 * _delta
		
	area_3d.force_update_transform()
	
	velocity /= NetworkTime.physics_factor
	move_and_slide()
	velocity *= NetworkTime.physics_factor


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Ball:
		log.info(body.name + " entered")
		#print("tick %d: entered " % NetworkTime.tick, body, " on ", "server" if multiplayer.is_server() else "client")
		#body.impulse(NetworkTime.tick, Vector3.UP * 10.0)
