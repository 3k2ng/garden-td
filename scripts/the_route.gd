extends Node2D

@export var wait = 1
@export var health = 200
var format = "Health: %s"
var slug_spawn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = wait
	$Timer.start()
	$Label.text = format % health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for _i in $Path2D.get_children():
		var old_location = _i.global_position
		_i.progress += _i.speed*delta
		
		if (_i.progress_ratio >= 1.0):
			_i.queue_free()
			health -= _i.damage
			$Label.text = format % health

func _on_timer_timeout():
	var spawn
	if (slug_spawn):
		spawn = preload("res://objects/slug.tscn").instantiate()
		slug_spawn = false
	else:
		spawn = preload("res://objects/ant.tscn").instantiate()
		slug_spawn = true
		
	spawn.loop = false
	#spawn.rotates = false
	$Path2D.add_child(spawn)
	
	
	
