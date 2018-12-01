extends Label

var total_seconds = 0

func _ready():
	print_time()


func print_time():
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	text = "%02d:%02d" % [minutes, seconds]


func add_second():
	total_seconds += 1
	print_time()


func _on_Timer_timeout():
	add_second()
