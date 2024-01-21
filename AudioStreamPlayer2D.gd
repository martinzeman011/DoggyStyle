extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	stream.loop = true
	
	# Přehrát smyčku
	play()
