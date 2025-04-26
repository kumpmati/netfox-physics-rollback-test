extends Node

const PORT = 8192

## Map of all connected players' infos
var players : Dictionary[int, Dictionary] = {}

## Local player's info. Edited before joining a lobby.
var own_player_info := {}

var players_loaded := 0

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

## Join a lobby in the given address.
func join_game(address : String) -> Error:
	var arr := address.split(":", false, 1)
	
	var ip := "127.0.0.1" if arr[0].is_empty() else arr[0]
	var port := PORT
	if arr.size() == 2:
		port = int(arr[1])
	
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_client(ip, port)
	if error: return error
	
	multiplayer.multiplayer_peer = peer
	return OK

## Host a lobby on this computer.
func create_game() -> Error:
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_server(PORT, 32)
	if error: return error
	multiplayer.multiplayer_peer = peer
	
	# set self as host
	own_player_info.peer_id = 1
	own_player_info.name = "Host"
	
	players[1] = own_player_info
	
	return Error.OK

## Stop hosting lobby
func destroy_game() -> void:
	multiplayer.multiplayer_peer.close()

func disconnect_self() -> void:
	multiplayer.multiplayer_peer.close()

## When a client connects, send them my player info.
## This allows transfer of all desired data for each player, not only unique ID
func _on_player_connected(peer_id : int) -> void:
	_register_player.rpc_id(peer_id, own_player_info)


# When the server decides to start the game from a UI scene,
# do Lobby.load_level.rpc(filepath)
@rpc("any_peer", "call_local", "reliable")
func load_level(scene_path : String) -> void:
	get_tree().change_scene_to_file(scene_path)


## Each client will call this function when they have loaded the scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded() -> void:
	if multiplayer.is_server():
		players_loaded += 1
		# when every player has loaded, start level for all players
		if players_loaded == players.size():
			players_loaded = 0



@rpc("any_peer", "reliable")
func _register_player(new_player_info : Dictionary) -> void:
	var new_player_id := multiplayer.get_remote_sender_id()
	
	players[new_player_id] = new_player_info


func _on_player_disconnected(peer_id : int) -> void:
	players.erase(peer_id)
	
	if peer_id == own_player_info.peer_id:
		get_tree().reload_current_scene()


func _on_connected_ok() -> void:
	var peer_id := multiplayer.get_unique_id()
	
	own_player_info.peer_id = peer_id
	own_player_info.name = "Player :-)"
	
	players[peer_id] = own_player_info


func _on_connected_fail() -> void:
	multiplayer.multiplayer_peer = null


func _on_server_disconnected() -> void:
	multiplayer.multiplayer_peer = null
	players.clear()
