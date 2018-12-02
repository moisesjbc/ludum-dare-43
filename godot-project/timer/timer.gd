extends Label

var seconds = 0
var minutes = 0


func _ready():
	pass
	

func _process(delta):
	# First version of this timer relied on a Godot Timer firing every one second
	# but we would have lost precision when decrementing time (ie. for shooting).
	seconds += delta
	if seconds > 60:
		seconds -= 60
		minutes += 1
	print_time()


func decrement(delta_seconds):
	if seconds > delta_seconds:
		seconds -= delta_seconds
		if seconds < 0:
			if minutes > 1:
				seconds = 60 + seconds
				minutes -= 1
		return true
	else:
		return false


func print_time():
	text = "%02d:%02d" % [minutes, seconds]


func _on_player_time_shoot(delta_seconds):
	decrement_time(delta_seconds)
