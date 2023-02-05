extends Area2D

@export var time_to_target: float = 2

var _time_traveled = 0
var _end_position: Vector2
var _start_position: Vector2
var _target

func init(target) -> void:
	_target = target.get_node("CharacterBody2D/Target")
	_start_position = position

func _on_area_entered(area):
	queue_free()

func _process(delta):
	if (is_instance_valid(_target)):
		_time_traveled+=delta 
		_end_position = _target.position
		position = lerp(_start_position, _end_position, _time_traveled/time_to_target)
	else:
		pass
