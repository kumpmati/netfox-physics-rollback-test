extends Node2D

const PLAYER_2D = preload("uid://dadkg5215t8ul")
@onready var label: Label = $ClientServerLabel

func _ready() -> void:
	label.text = "server" if multiplayer.is_server() else "client"
	
	if multiplayer.is_server():
		await get_tree().create_timer(1).timeout
		_spawn_players()


func _spawn_players() -> void:
	for id in Lobby.players:
		_spawn(id)


func _spawn(id: int) -> void:
	var player := PLAYER_2D.instantiate() as Player2D
	player.name = str(id)
	add_child(player)
	player.global_position = (Vector2.UP * 50).rotated(hash(id) * 2 * PI)


func _on_network_area_3d_rollback_body_entered(body: Node3D, tick: int) -> void:
	print(body, " enter ", tick)


func _on_network_area_3d_rollback_body_exited(body: Node3D, tick: int) -> void:
	print(body, " exit ", tick)


func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body, " enter ")


func _on_area_3d_body_exited(body: Node3D) -> void:
	print(body, " exit ")


func _on_network_area_2d_rollback_body_entered(body: Node2D, tick: int) -> void:
	print(body, " entered on tick ", tick)


func _on_network_area_2d_rollback_body_exited(body: Node2D, tick: int) -> void:
	print(body, " exited on tick ", tick)
