extends KinematicBody2D

enum AmmoType {
  TIME,
  LIFE
}

export (int) var speed = 500
export (Texture) var life_bullet_texture
export (Texture) var time_bullet_texture

var ammo_type = AmmoType.LIFE


func _process(delta):
	var velocity = (Vector2(1, 0) * speed * delta).rotated(rotation)
	var collision = move_and_collide(velocity)
	if collision:
		queue_free()
		if collision.collider.is_in_group('zombies') and collision.collider.zombie_type == ammo_type:
			collision.collider.queue_free()


func _on_bullet_visibility_viewport_exited(viewport):
	queue_free()


func set_ammo_type(new_ammo_type):
	ammo_type = new_ammo_type
	if ammo_type == AmmoType.LIFE:
		$bullet_sprite.texture = life_bullet_texture
	else:
		$bullet_sprite.texture = time_bullet_texture
