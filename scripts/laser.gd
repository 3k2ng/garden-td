extends Node2D

@export var projectile_scene: PackedScene

var projectile
var last_target

func shoot(target):
	if (not is_instance_valid(projectile)):
		projectile = projectile_scene.instantiate()
		get_tree().get_root().add_child(projectile)
		projectile.position = global_position
	if (last_target != target):
		projectile.aim(target)

func stop_shooting():
	last_target=null
	if (is_instance_valid(projectile)):
		projectile.queue_free()
	
