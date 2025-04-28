extends Area3D
class_name NetworkArea3D

signal rollback_body_entered(body: Node3D, tick: int)
signal rollback_body_exited(body: Node3D, tick: int)


var _logger := _NetfoxLogger.for_extras("NetworkArea3D")
var _body_history := _HistoryBuffer.new()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	NetworkTime.before_tick.connect(_before_tick)
	NetworkTime.after_tick_loop.connect(_after_loop)

func _before_tick(_d: float, tick: int):
	if not _body_history.has(tick + 1):
		_body_history.set_snapshot(tick + 1, {})

func _after_loop():
	var tick := NetworkTime.tick
	
	var current = _body_history.get_snapshot(tick)
	var prev = _body_history.get_snapshot(tick - 1)
	
	# current should never be null, but check just in case
	if current == null or prev == null:
		return
	
	for body in current:
		if not prev.has(body):
			_logger.info("entered: " + body.to_string())
	
	for body in prev:
		if not current.has(body):
			_logger.info("exited: " + body.to_string())
	
	
	
	_body_history.trim(NetworkRollback.history_start)


func _on_body_entered(body: Node3D):
	var tick := NetworkTime.tick
	
	# TODO: handle characterbody and rigidbody differently
	_logger.info("BODY ENTER AAAAAAAAAAAA"+body.to_string())
	
	if _body_history.has(tick):
		var dict: Dictionary = _body_history.get_snapshot(tick)
		dict.set(body, true)
		_body_history.set_snapshot(tick, dict)
	else:
		_logger.error("no snapshot for this tick")
