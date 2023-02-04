extends Node2D

@export var wait = 1
var health = 200
var format = "Health: %s"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = wait
	$Timer.start()
	$Label.text = format % health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for _i in $Path2D.get_children():
		_i.progress += _i.speed*delta
		_i.global_rotation = 0
		
		if (_i.progress_ratio >= 1.0):
			_i.queue_free()
			health -= _i.damage
			$Label.text = format % health

func _on_timer_timeout():
	var spawn = preload("res://objects/character.tscn").instantiate()
	$Path2D.add_child(spawn)
	spawn.loop = false
	
	
