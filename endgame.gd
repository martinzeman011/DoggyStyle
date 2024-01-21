extends Control

class_name EndGame

var audioplayer : AudioStreamPlayer2D
var sound_enabled : bool = true

@onready var label = $Label

#ukládání skore
var save_path = "user://save/"
var save_name = "PlayerSave.tres"

var playerData = PlayerData.new()

var player_score = null


func _ready():
	audioplayer = $AudioStreamPlayer2D
	playerData = ResourceLoader.load(save_path + save_name).duplicate(true)
	player_score = playerData.score
	label.text = label.text + " " + str(player_score)

func _on_sound_pressed():
	if sound_enabled:
		audioplayer.stop()
		sound_enabled = false
	else:
		audioplayer.play()
		sound_enabled = true







func _on_restart_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_go_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
