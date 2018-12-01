extends KinematicBody2D

export (int) var speed = 250
export (PackedScene) var bullet_scene = null;


func _process(delta):
	move_player(delta)
	rotate_player(delta)
	process_player_shoot(delta)


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


func process_player_shoot(delta):
	if Input.is_action_pressed('ui_shoot'):
		var bullet = bullet_scene.instance()
		get_tree().get_root().get_node('main').add_child(bullet)
		bullet.global_position = $bullets_spawn.global_position
		bullet.rotation = rotation


func rotate_player(delta):
	# Source: https://www.reddit.com/r/godot/comments/6yb67w/rotating_a_sprite_to_always_face_towards_the/
	look_at(get_global_mouse_position())