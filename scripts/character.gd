extends PathFollow2D

@export var damage = 5
@export var speed = 300
@export var health = 20
@export var flying = false
@export var value = 30
var alive = true

func hurt(attack_damage):
	health -= attack_damage
	if (health <= 0):
		alive = false
