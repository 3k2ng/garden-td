extends Node2D

@export var wait = 1
@export var health = 200
var format = "Health: %s"
var spawn_type: Array[String] = ["res://objects/slug.tscn", "res://objects/ant.tscn", "res://objects/aphid.tscn"]
var spawn_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = wait
	$Timer.start()
	$Label.text = format % health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for _i in $Path2D.get_children():
		_i.progress += _i.speed*delta
		
		if (_i.progress_ratio >= 1.0):
			_i.queue_free()
			health -= _i.damage
			$Label.text = format % health

func _on_timer_timeout():
	var spawn
	spawn = load(spawn_type[spawn_index % spawn_type.size()]).instantiate()
	spawn_index += 1
	$Path2D.add_child(spawn)
	
	
	
