extends Node2D

var _can_be_placed: bool = true

@onready var _being_placed: bool = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		if _being_placed:
			place()

func _physics_process(delta: float) -> void:
	if _being_placed:
		position = get_global_mouse_position()

func place() -> void:
	if _can_be_placed:
		_being_placed = false

func _on_area_2d_area_entered(area):
	_can_be_placed = false


func _on_area_2d_area_exited(area):
	_can_be_placed = true
