extends KinematicBody2D

export (int) var speed = 500
onready var player = get_node('../player')


func _process(delta):
	look_at(player.global_position)
	var direction = Vector2(1.0, 0.0).rotated(rotation)
	var velocity = direction * speed * delta
	move_and_collide(velocity)
