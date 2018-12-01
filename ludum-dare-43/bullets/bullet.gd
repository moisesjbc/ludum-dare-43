extends KinematicBody2D

export (int) var speed = 20000

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var velocity = (Vector2(1, 0) * speed * delta).rotated(rotation)
	move_and_slide(velocity)


func _on_bullet_visibility_viewport_exited(viewport):
	queue_free()
