extends Node2D

const INVENTROY_SIZE = 5
var up = false

func _ready():
	$GridContainer.columns = INVENTROY_SIZE
	$AnimationPlayer.play("inventory")

func _on_button_pressed():
	if up:
		$AnimationPlayer.play("inventory")
		up = false
	else:
		$AnimationPlayer.play_backwards("inventory")
		up = true

func add(component) -> bool:
	if ($GridContainer.get_child_count() ==  INVENTROY_SIZE):
		return false
	$GridContainer.add_theme_constant_override("h_separation",component.size.x)
	$GridContainer.add_child(component)
	return true

func _on_button_2_pressed():
	add(load("res://objects/test_objects/test_inventory_item.tscn").instantiate())
