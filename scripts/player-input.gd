class_name PlayerInput
extends Node

# Player input variables
var move_wish_dir := Vector3.ZERO

func _ready() -> void:
	NetworkTime.before_tick_loop.connect(_gather)


func _gather() -> void:
	if not is_multiplayer_authority(): 
		return
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	move_wish_dir = Vector3(input_dir.x, 0, input_dir.y)
