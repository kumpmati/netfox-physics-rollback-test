extends Node
class_name _NetworkInput

## Wrapper over Godot's Input singleton that works with
## Netfox's network ticks in cases where it's needed

var _actions: Dictionary[StringName, _HistoryBuffer] = {}

## Encodes the state of an action to an enum that can be synced to peers
enum InputState {
	NONE,
	JUST_PRESSED,
	PRESSED,
	JUST_RELEASED
}


## Returns [code]true[/code] if the given state is pressed or was just pressed this network tick
func is_pressed(state: InputState) -> bool:
	return state == InputState.JUST_PRESSED or state == InputState.PRESSED

## Returns [code]true[/code] if the given state was just pressed this network tick
func is_just_pressed(state: InputState) -> bool:
	return state == InputState.JUST_PRESSED

## Returns [code]true[/code] if the given state was just released this network tick
func is_just_released(state: InputState) -> bool:
	return state == InputState.JUST_RELEASED

## Returns [code]true[/code] if the given state has not been pressed this or last tick
func is_not_pressed(state: InputState) -> bool:
	return state == InputState.NONE


## Returns the current state for [param action] in a format that can be synchronized
func get_action_state(action: StringName, tick := NetworkTime.tick) -> InputState:
	_update_action_history(action)
	
	var pressed: bool = _get_snapshot(action, tick)
	var was_pressed: bool = _get_snapshot(action, tick - 1)
	
	if pressed != was_pressed:
		return InputState.JUST_PRESSED if pressed else InputState.JUST_RELEASED
	return InputState.PRESSED if pressed else InputState.NONE


## Updates the press and release ticks of the given action.
func _update_action_history(action: StringName) -> void:
	if !_actions.has(action):
		_actions.set(action, _HistoryBuffer.new())
	
	var history: _HistoryBuffer = _actions.get(action)
	var tick := NetworkTime.tick
	
	if history.has(tick):
		# prevent multiple updates per tick
		return
	
	history.set_snapshot(tick, Input.is_action_pressed(action))
	
	# only previous two ticks needed to capture transients
	history.trim(tick - 1)


## Returns the snapshot for [param action] at [param tick] if it exists,
## or false if it doesn't exist
func _get_snapshot(action: StringName, tick: int) -> bool:
	if _actions.has(action):
		var history: _HistoryBuffer = _actions.get(action)
		if history.has(tick):
			return history.get_snapshot(tick)
	return false
