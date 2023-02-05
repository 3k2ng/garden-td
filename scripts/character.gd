extends PathFollow2D

@export var damage = 5
@export var speed = 300
@export var health = 20
@export var flying = false
@export var value = 30

func _process(delta):
	if (health <= 0):
		queue_free()
