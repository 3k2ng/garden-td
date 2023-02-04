extends Node2D

const GHOST_ALPHA = 0.8

var _can_be_placed: bool = true
var _enemies_in_range: Dictionary = {}

@onready var place_area = $PlaceArea
@onready var shoot_area = $ShootArea
@onready var shoot_area_shape = $ShootArea/CollisionShape2D
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
		place_area.monitoring = false
		place_area.monitorable = true
		shoot_area_shape.disabled = false
		sprite.modulate = Color(1,1,1,1)
		_being_placed = false

func _on_place_area_entered(_area: Area2D) -> void:
	sprite.modulate = Color(1,0,0,GHOST_ALPHA)
	_can_be_placed = false

func _on_place_area_exited(_area: Area2D) -> void:
	sprite.modulate = Color(1,1,1,GHOST_ALPHA)
	_can_be_placed = true

func _on_shoot_area_entered(area):
	_enemies_in_range[area.get_parent().name] = area.get_parent()

func _on_shoot_area_exited(area):
	_enemies_in_range.erase(area.get_parent().name)
