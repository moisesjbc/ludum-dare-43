extends KinematicBody2D

export (int) var speed = 500
export (int) var bite_cooldown = 0.5
export (int) var life_bite_damage = 15
export (int) var time_bite_damage = 1
var bite_current_cooldown = 0
onready var player = get_tree().get_root().get_node('main/player')
signal life_bite
signal time_bite
export (Texture) var time_zombie_texture
export (Texture) var life_zombie_texture
export (float) var time_zombie_probability = 0.2
export (AudioStream) var bite_1
export (AudioStream) var bite_2

const bullet_script = preload("res://bullets/bullet.gd")
export (bullet_script.AmmoType) var zombie_type = bullet_script.AmmoType.LIFE


func _ready():
	if randf() < 0.5:
		$bite_sound.stream = bite_1
	else:
		$bite_sound.stream = bite_2
				
	if randf() <= time_zombie_probability:
		set_type(bullet_script.AmmoType.TIME)
	else:
		set_type(bullet_script.AmmoType.LIFE)


func set_type(new_zombie_type):
	zombie_type = new_zombie_type
	if zombie_type == bullet_script.AmmoType.LIFE:
		connect("life_bite", player, "_on_zombie_life_bite")
		$zombie_sprite.texture = life_zombie_texture
	else:
		connect("time_bite", player, "_on_zombie_time_bite")
		$zombie_sprite.texture = time_zombie_texture


func _process(delta):
	bite_current_cooldown -= delta
	look_at(player.global_position)
	var direction = Vector2(1.0, 0.0).rotated(rotation)
	var velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		if collision.get_collider().name == 'player' and bite_current_cooldown <= 0:
			$bite_sound.play()
			bite_current_cooldown = bite_cooldown
			if zombie_type == bullet_script.AmmoType.LIFE:
				emit_signal('life_bite', life_bite_damage)
			else:
				emit_signal('time_bite', time_bite_damage)
		elif collision.collider.is_in_group('zombies'):
			collision.collider.move_and_collide(-(position - collision.collider.position).normalized() * speed * delta * 2)
