extends Area2D

@onready var _shape = $CollisionShape2D
@onready var _line = $Line2D

func aim(target):
	_shape.shape.b = target.global_position - position
	_line.points = [Vector2(0,0), target.global_position - position]
