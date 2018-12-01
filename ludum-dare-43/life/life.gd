extends Label

var life = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print_life()

func decrement(life_delta):
	life -= life_delta
	print_life()
	return true
	
func print_life():
	text = "%03d" % life