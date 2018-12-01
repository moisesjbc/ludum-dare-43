extends CenterContainer


func _ready():
	hide()


func display():
	get_tree().paused = true
	show()


func _on_restart_game_button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://main/main.tscn")


func _on_life_player_died():
	display()
