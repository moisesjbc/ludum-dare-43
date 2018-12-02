extends Path2D

export (PackedScene) var zombie_scene


func respawn_zombie():
	var zombie = zombie_scene.instance()
	add_child(zombie)
	zombie.position = $PathFollow2D.position
	$PathFollow2D.set_offset(randi())


func _on_zombies_respawn_timer_timeout():
	respawn_zombie()
