extends Area2D

var consistent = false
@export var time_to_target: float = 0.3

var _time_traveled = 0
var _end_position: Vector2
var _start_position: Vector2
var _target

func init(target) -> void:
	_target = target
	_start_position = position

func _on_area_entered(area):
	area.get_parent().hurt(4)
	queue_free()

func _process(delta):
	_time_traveled+=delta 
	if (is_instance_valid(_target)):
		_end_position = _target.global_position
	position = lerp(_start_position, _end_position, _time_traveled/time_to_target)
