extends KinematicBody2D

export (int) var speed = 250
export (PackedScene) var bullet_scene = null;
export (NodePath) var timer_path = null;
onready var timer = get_node(timer_path)

export (NodePath) var life_path = null;
onready var life = get_node(life_path)

const bullet_script = preload("res://bullets/bullet.gd")
export (bullet_script.AmmoType) var ammo_type = bullet_script.AmmoType.LIFE
var on_shoot_cooldown = false

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
		
	var velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	
	# Push zombies away
	# Source: https://godotengine.org/qa/28117/how-to-push-another-kinematicbody2d
	if collision and collision.collider.is_in_group('zombies'):
		collision.collider.move_and_collide(-(position - collision.collider.position).normalized() * speed * delta * 2)


func process_player_shoot(delta):
	if Input.is_action_just_pressed('ui_ammo_switch'):
		if ammo_type == bullet_script.AmmoType.TIME:
			$ammo_type_sprite.set_modulate(Color(1.0, 0.0, 0.0, 1.0))
			ammo_type = bullet_script.AmmoType.LIFE
		else:
			$ammo_type_sprite.set_modulate(Color(0.0, 1.0, 0.0, 1.0))
			ammo_type = bullet_script.AmmoType.TIME
	
	if Input.is_action_pressed('ui_shoot') and not on_shoot_cooldown:
		$shoot.play()
		start_shoot_cooldown()
		
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


func start_shoot_cooldown():
	on_shoot_cooldown = true
	$shoot_cooldown_timer.start()


func _on_zombie_life_bite(delta):
	life.decrement(delta)


func _on_zombie_time_bite(delta):
	timer.decrement(delta)


func _on_shoot_cooldown_timer_timeout():
	on_shoot_cooldown = false


func _on_health_powerup_picked(heal_points):
	$heal_sound.play()
	life.increment(heal_points)
