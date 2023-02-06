extends Node2D

const INVENTROY_SIZE = 5
var up = false

func _ready():
	$GridContainer.columns = INVENTROY_SIZE
	$AnimationPlayer.play_backwards("inventory")
	up = false

func _on_button_pressed():
	if up:
		$AnimationPlayer.play_backwards("inventory")
		up = false
	else:
		$AnimationPlayer.play("inventory")
		up = true

func add(component) -> bool:
	if ($GridContainer.get_child_count() ==  INVENTROY_SIZE):
		return false
	
	$GridContainer.add_theme_constant_override("h_separation",0)
	$GridContainer.add_child(component)
	return true

func _on_button_2_pressed():
	add(load("res://objects/inventory_item.tscn").instantiate())
