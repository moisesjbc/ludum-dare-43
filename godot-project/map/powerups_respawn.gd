extends Node2D

export (PackedScene) var health_powerup_scene


func _on_respawn_timer_timeout():
	var x = rand_range($left_top_corner.position.x, $right_bot_corner.position.x)
	var y = rand_range($left_top_corner.position.y, $right_bot_corner.position.y)
	var powerup_position = Vector2(x, y)
	
	var powerup = health_powerup_scene.instance()
	powerup.position = powerup_position
	add_child(powerup)