extends CanvasLayer

func _on_start_game_button_pressed():
	get_tree().change_scene("res://main/main.tscn")


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene("res://menus/credits_menu/credits_menu.tscn")