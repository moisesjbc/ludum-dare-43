extends KinematicBody2D

export (int) var speed = 250


func _process(delta):
	move_player(delta)
	rotate_player(delta)


func move_player(delta):
	var direction = Vector2(0, 0)
	
	# Vertical movement
	if Input.is_action_pressed('ui_up'):
		direction.y = -1.0
	elif Input.is_action_pressed('ui_down'):
		direction.y = 1.0
		
	# Horizontal movement
	if Input.is_action_pressed('ui_left'):
		direction.x = -1.0
	elif Input.is_action_pressed('ui_right'):
		direction.x = 1.0
		
	position += direction * speed * delta


func rotate_player(delta):
	# Source: https://godotengine.org/qa/19285/rotate-sprite-in-the-direction-of-movement
	var angle = position.angle_to_point(get_global_mouse_position())
	rotation = angle