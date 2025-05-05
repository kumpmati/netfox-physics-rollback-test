class_name PlayerInput2D
extends Node

# Player input variables
var move_wish_dir := Vector2.ZERO

func _ready() -> void:
	NetworkTime.before_tick_loop.connect(_gather)


func _gather() -> void:
	if not is_multiplayer_authority(): 
		return
	
	move_wish_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
