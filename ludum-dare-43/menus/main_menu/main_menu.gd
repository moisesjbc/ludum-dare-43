extends CanvasLayer




func _ready():
	print_sound_mode()


func _on_start_game_button_pressed():
	get_tree().change_scene("res://main/main.tscn")


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene("res://menus/credits_menu/credits_menu.tscn")


func _on_toggle_sound_button_pressed():
	get_node('/root/global').toggle_sound_mode()
	print_sound_mode()


func print_sound_mode():
	var sound_mode = get_node('/root/global').sound_mode
	var sound_mode_label = ''
	if sound_mode == get_node('/root/global').SoundMode.FULL:
		sound_mode_label = 'FULL'
	elif sound_mode == get_node('/root/global').SoundMode.FX_ONLY:
		sound_mode_label = 'FX ONLY'
	else:
		sound_mode_label = 'MUTED'
		
	$CenterContainer/VBoxContainer/toggle_sound_button.text = "Toggle sound mode [" + sound_mode_label + "]"