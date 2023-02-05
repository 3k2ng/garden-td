extends Area2D

@export var velocity: float = 200

var _direction: Vector2
var _target

func init(target) -> void:
	_target=target

func _on_area_entered(area):
	queue_free()

func _process(delta):
	if (is_instance_valid(_target)): 
		_direction = (_target.position - position).normalized()
	position += _direction * delta * velocity

func _on_timeout():
	queue_free()
