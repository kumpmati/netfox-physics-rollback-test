extends Control

func _ready() -> void:
	if OS.has_feature("editor"):
		print("running in editor, hosting / joining automatically...")
		var err := Lobby.create_game()
		if err == ERR_CANT_CREATE:
			Lobby.join_game("127.0.0.1")


func _on_start_pressed() -> void:
	Lobby.load_level.rpc("res://scenes/level.tscn")
