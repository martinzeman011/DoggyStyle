extends Area2D
class_name InteractionArea2

@export var action_name: String = "Drink"


var interact: Callable = func():
	pass


func _on_body_entered(_body):
	InteractionManager2.register_second_area(self)


func _on_body_exited(_body):
	InteractionManager2.unregister_second_area(self)
