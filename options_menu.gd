extends Control


var audioplayer : AudioStreamPlayer2D
var sound_enabled : bool = true


func _ready():
	audioplayer = $AudioStreamPlayer2D


func _on_sound_pressed():
	if sound_enabled:
		audioplayer.stop()
		sound_enabled = false
	else:
		audioplayer.play()
		sound_enabled = true





func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
