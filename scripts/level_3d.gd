extends Node3D

const PLAYER_3D = preload("uid://d3a88k0p6i2jw")
@onready var label: Label = $Label

func _ready() -> void:
	label.text = "server" if multiplayer.is_server() else "client"
	
	if multiplayer.is_server():
		await get_tree().create_timer(1).timeout
		_spawn_players()


func _spawn_players() -> void:
	for id in Lobby.players:
		_spawn(id)


func _spawn(id: int) -> void:
	var player := PLAYER_3D.instantiate() as Player
	player.name = str(id)
	add_child(player)
	player.global_position = (Vector3.FORWARD * 2).rotated(Vector3.UP, hash(id) * 2 * PI)
	player.global_position.y = 1


func _on_network_area_3d_rollback_body_entered(body: Node3D, tick: int) -> void:
	print(body, " entered on tick ", tick)


func _on_network_area_3d_rollback_body_exited(body: Node3D, tick: int) -> void:
	print(body, " exited on tick ", tick)
