extends Node3D

const PLAYER = preload("uid://d3a88k0p6i2jw")

func _ready() -> void:
	if multiplayer.is_server():
		await get_tree().create_timer(5).timeout
		_spawn_players()


func _spawn_players() -> void:
	for id in Lobby.players:
		_spawn(id)


func _spawn(id: int) -> void:
	var player := PLAYER.instantiate() as Player
	player.name = str(id)
	add_child(player)
	player.global_position = (Vector3.FORWARD * 2).rotated(Vector3.UP, hash(id) * 2 * PI)
	player.global_position.y = 1
