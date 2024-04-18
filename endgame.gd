extends Control

class_name EndGame

var audioplayer : AudioStreamPlayer2D
var sound_enabled : bool = true

@onready var label = $Label
@onready var label2 = $Label2
@onready var win = $Win
@onready var defeat = $Defeat
@onready var draww = $Draw
@onready var exp_label = $Exp


#ukládání skore
var save_path = "user://save/"
var save_name = "PlayerSave.tres"
var save_name_e = "EnemySave.tres"
var save_xp = "Exp.tres"

var playerData = PlayerData.new()
var enemyData = PlayerData.new()

var playerXP = PlayerData.new()

var player_score = null
var enemy_score = null
var exp = null
var points = null

func _ready():
	audioplayer = $AudioStreamPlayer2D
	playerData = ResourceLoader.load(save_path + save_name).duplicate(true)
	enemyData = ResourceLoader.load(save_path + save_name_e).duplicate(true)
	playerXP = ResourceLoader.load(save_path + save_xp).duplicate(true)
	player_score = playerData.score
	enemy_score = enemyData.score
	
	label.text = label.text + " " + str(player_score)
	label2.text = label2.text + " " + str(enemy_score)

	
	if player_score > enemy_score:
		exp = player_score - enemy_score
		points = exp + playerXP.score
		playerXP.score = 0
		playerXP.change_score(points)
		exp_label.text =  "+" + " " + str(exp) + "XP"
		savexp()
		win.show()
	elif player_score == enemy_score:
		exp_label.text = "+" + " " + "0" + "XP"
		draww.show()		
	else:
		exp = enemy_score - player_score
		points = playerXP.score - exp
		playerXP.score = 0
		playerXP.change_score(points)
		exp_label.text = "-" + " " + str(exp) + "XP"
		savexp()
		defeat.show()
		

func _on_sound_pressed():
	if sound_enabled:
		audioplayer.stop()
		sound_enabled = false
	else:
		audioplayer.play()
		sound_enabled = true




func savexp() -> void:
	ResourceSaver.save(playerXP, save_path + save_xp)
	print("ukládám!" + str(points) + " " + str(playerXP.score))


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_go_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
