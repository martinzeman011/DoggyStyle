extends Resource

class_name PlayerData


@export var score = 0
@export var high_score = 0

func reset_score():
	score = 0

func change_score(value : float):
	score += value

func change_high_score(value : float):
	high_score = value
