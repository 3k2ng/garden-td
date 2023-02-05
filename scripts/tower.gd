extends Node2D

const GHOST_ALPHA = 0.8

@export var attack_time: float = 0.3

var _target = null
var _can_be_placed: bool = true
var _enemies_in_range: Dictionary = {}
var _time_since_attack: float = attack_time

@onready var sprite = $Sprite2D
@onready var place_area = $PlaceArea
@onready var shoot_area = $ShootArea
@onready var shoot_area_shape = $ShootArea/CollisionShape2D
@onready var retarget_timer = $RetargetTimer
@onready var shooter = $Shooter

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

func _process(delta: float) -> void:
	if not _being_placed:
		_time_since_attack+=delta
		if _time_since_attack>=attack_time:
			attack()
			_time_since_attack = 0.0

func place() -> void:
	if _can_be_placed:
		place_area.monitoring = false
		place_area.monitorable = true
		shoot_area_shape.disabled = false
		retarget_timer.start()
		sprite.modulate = Color(1,1,1,1)
		_being_placed = false

func attack() -> void:
	if _target != null:
		shooter.shoot(_target)
	else:
		shooter.stop_shooting()

func retarget() -> void:
	var enemies = _enemies_in_range.values()
	if(not enemies.is_empty()):
		enemies.sort_custom(distance_on_path)
		_target=enemies[0]
	else:
		_target=null

func _on_place_area_entered(_area: Area2D) -> void:
	sprite.modulate = Color(1,0,0,GHOST_ALPHA)
	_can_be_placed = false
	retarget()

func _on_place_area_exited(_area: Area2D) -> void:
	sprite.modulate = Color(1,1,1,GHOST_ALPHA)
	_can_be_placed = true
	retarget()

func _on_shoot_area_entered(area):
	_enemies_in_range[area.get_parent().name] = area.get_parent()

func _on_shoot_area_exited(area):
	_enemies_in_range.erase(area.get_parent().name)
	if(area.get_parent()==_target): retarget()

func distance_on_path(a,b):
	return a.progress > b.progress
