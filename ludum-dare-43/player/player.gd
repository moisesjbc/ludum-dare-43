extends KinematicBody2D

export (int) var speed = 250


func _process(delta):
	var direction = Vector2(0, 0)
	if Input.is_action_pressed('ui_up'):
		direction.y = -1.0
	elif Input.is_action_pressed('ui_down'):
		direction.y = 1.0
		
	if Input.is_action_pressed('ui_left'):
		direction.x = -1.0
	elif Input.is_action_pressed('ui_right'):
		direction.x = 1.0

	position += direction * speed * delta