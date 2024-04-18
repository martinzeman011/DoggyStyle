extends Control

@onready var label = $Label

var audioplayer : AudioStreamPlayer2D
var sound_enabled : bool = true

var save_path = "user://save/"
var save_xp = "Exp.tres"

var playerXP = PlayerData.new()
var exp = null


func _ready():
	audioplayer = $AudioStreamPlayer2D
	playerXP = ResourceLoader.load(save_path + save_xp).duplicate(true)
	label.text = label.text + str(playerXP.score)







func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://item_shop.tscn")


func _on_inventory_pressed():
	get_tree().change_scene_to_file("res://inventory.tscn")
