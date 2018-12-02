extends Label

var life = 100
signal player_died

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print_life()

func decrement(life_delta):
	life -= life_delta
	if life < 0:
		life = 0
		print_life()
		emit_signal('player_died')
		return false
	else:
		print_life()
		return true


func increment(life_delta):
	life += life_delta
	if life > 100:
		life = 100
	print_life()


func print_life():
	text = "%03d" % life


