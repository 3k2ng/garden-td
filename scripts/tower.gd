extends Node2D

const GHOST_ALPHA = 0.8

var _can_be_placed: bool = true

@onready var area = $Area2D
@onready var sprite = $Sprite2D
@onready var _being_placed: bool = true

func _ready():
	sprite.modulate = Color(1,1,1,GHOST_ALPHA)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("interact"):
		if _being_placed:
			place()

func _physics_process(delta: float) -> void:
	if _being_placed:
		position = get_global_mouse_position()

func place() -> void:
	if _can_be_placed:
		area.monitoring = false
		area.monitorable = true
		sprite.modulate = Color(1,1,1,1)
		_being_placed = false

func _on_area_2d_area_entered(area):
	sprite.modulate = Color(1,0,0,GHOST_ALPHA)
	_can_be_placed = false


func _on_area_2d_area_exited(area):
	sprite.modulate = Color(1,1,1,GHOST_ALPHA)
	_can_be_placed = true
