extends KinematicBody2D

enum AmmoType {
  TIME,
  LIFE
}

export (int) var speed = 20000
var ammo_type = AmmoType.LIFE


func _process(delta):
	var velocity = (Vector2(1, 0) * speed * delta).rotated(rotation)
	move_and_slide(velocity)


func _on_bullet_visibility_viewport_exited(viewport):
	queue_free()


func set_ammo_type(new_ammo_type):
	ammo_type = new_ammo_type