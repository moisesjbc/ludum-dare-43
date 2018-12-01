extends KinematicBody2D

export (int) var speed = 250
export (PackedScene) var bullet_scene = null;
export (NodePath) var timer_path = null;
onready var timer = get_node(timer_path)

export (NodePath) var life_path = null;
onready var life = get_node(life_path)

const bullet_script = preload("res://bullets/bullet.gd")
export (bullet_script.AmmoType) var ammo_type = bullet_script.AmmoType.LIFE


signal time_shoot


func _ready():
	ammo_type = bullet_script.AmmoType.LIFE


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
		
	move_and_collide(direction * speed * delta)


func process_player_shoot(delta):
	if Input.is_action_just_pressed('ui_ammo_switch'):
		if ammo_type == bullet_script.AmmoType.TIME:
			ammo_type = bullet_script.AmmoType.LIFE
		else:
			ammo_type = bullet_script.AmmoType.TIME
	
	if Input.is_action_pressed('ui_shoot'):
		var ammo = life
		if ammo_type == bullet_script.AmmoType.TIME:
			ammo = timer
			
		if ammo.decrement(1):
			var bullet = bullet_scene.instance()
			bullet.set_ammo_type(ammo_type)
			get_tree().get_root().get_node('main').add_child(bullet)
			bullet.global_position = $bullets_spawn.global_position
			bullet.rotation = rotation


func rotate_player(delta):
	# Source: https://www.reddit.com/r/godot/comments/6yb67w/rotating_a_sprite_to_always_face_towards_the/
	look_at(get_global_mouse_position())


func _on_zombie_life_bite(delta):
	life.decrement(delta)


func _on_zombie_time_bite(delta):
	timer.decrement(delta)