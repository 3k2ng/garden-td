extends Button
@export var tower = "res://objects/test_objects/laser_tower.tscn"


func _on_pressed():
	print(get_node("/root/game"))
	var game = get_node("/root/game")
	game.add_child(load(tower).instantiate())
	queue_free()
