extends PathFollow2D

const FLIP_ANGLE = 90

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
		

func _process(delta):
	if(global_rotation_degrees > FLIP_ANGLE ||  (global_rotation_degrees < -FLIP_ANGLE)):
		$CharacterBody2D/AnimatedSprite2D.flip_v = true
	else:
		$CharacterBody2D/AnimatedSprite2D.flip_v = false
		
