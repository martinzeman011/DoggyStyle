extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D

func _ready():
	interaction_area.interact = Callable(self, "_toggle_lamp")

func _toggle_lamp():
	sprite.frame = 1 if sprite.frame == 0 else 0
