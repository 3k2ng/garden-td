extends Node2D

signal no_health
signal wave_done

const START_NUM_ENEMIES = 20

@export var health = 200
@export var remaining_spawns = 20
var wave_num = 0
var rand = RandomNumberGenerator.new()
var enemies_per_wave = 5

var format = "Health: %s\nWave: %s"
var spawn_type: Array[String] = ["res://objects/slug.tscn", "res://objects/ant.tscn", "res://objects/aphid.tscn", "res://objects/butterfly.tscn"]
var spawn_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize
	$Label.text = format % [health, wave_num]

func new_wave():
	wave_num += 1
	$Label.text = format % [health, wave_num]
	remaining_spawns = START_NUM_ENEMIES + wave_num * enemies_per_wave
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Path2D.get_child_count() == 0 && remaining_spawns == 0):
		emit_signal("wave_done")
		$Button.disabled = false
		$Button.show()
	
	for _i in $Path2D.get_children():
		_i.progress += _i.speed*delta
		
		if (_i.progress_ratio >= 1.0):
			_i.queue_free()
			health -= _i.damage
			$Label.text = format % [health, wave_num]
			
			if (health <= 0):
				$Timer.stop()
				$Label.text = "GAME OVER"
				emit_signal("no_health")
				for j in $Path2D.get_children():
					j.queue_free()


func _on_timer_timeout():
	remaining_spawns -= 1
	var spawn = load(spawn_type[rand.randi_range(0, spawn_type.size()-1)]).instantiate()
	spawn_index += 1
	$Path2D.add_child(spawn)
	if (remaining_spawns > 0):
		$Timer.wait_time = rand.randf_range(0.1, 1)
		$Timer.start()


func _on_button_pressed():
	new_wave()
	$Button.disabled = true
	$Button.hide()
