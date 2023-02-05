extends Node2D

@export var projectile_scene: PackedScene

func shoot(target):
	var projectile = projectile_scene.instantiate()
	get_tree().get_root().add_child(projectile)
	projectile.position = global_position
	projectile.init(target)

func stop_shooting():
	pass
