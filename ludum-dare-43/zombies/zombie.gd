extends KinematicBody2D

export (int) var speed = 500
export (int) var bite_cooldown = 0.5
export (int) var bite_damage = 15
var bite_current_cooldown = 0
onready var player = get_tree().get_root().get_node('main/player')
signal life_bite

func _ready():
	connect("life_bite", player, "_on_zombie_life_bite")


func _process(delta):
	bite_current_cooldown -= delta
	look_at(player.global_position)
	var direction = Vector2(1.0, 0.0).rotated(rotation)
	var velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision and collision.get_collider().name == 'player' and bite_current_cooldown <= 0:
		bite_current_cooldown = bite_cooldown
		emit_signal('life_bite', bite_damage)
