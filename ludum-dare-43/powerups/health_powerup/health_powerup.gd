extends Area2D

export (int) var heal_points = 15
onready var player = get_tree().get_root().get_node('main/player')
signal health_powerup_picked

func _ready():
	connect('health_powerup_picked', player, '_on_health_powerup_picked')


func _on_health_powerup_body_entered(body):
	if body == player:
		emit_signal('health_powerup_picked', heal_points)
		queue_free()
