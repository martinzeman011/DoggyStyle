extends Control

var save_path = "user://save/"
var save_corn = "Unicorn.tres"
var save_hoodie = "Hoodie.tres"
var save_glass = "Glasses.tres"

var hood = PlayerData.new()
var corn = PlayerData.new()
var glass = PlayerData.new()

@onready var hoodie = $GridContainer/Hoodie
@onready var hoodie_check = $GridContainer/Hoodie/HoodieCheck
@onready var h_rew = $Hoodie_rew
@onready var glasses = $GridContainer/Glasses
@onready var glasses_check = $GridContainer/Glasses/GlassesCheck
@onready var g_rew = $Glasses_rew
@onready var unicorn = $GridContainer/Unicorn
@onready var unicorn_check = $GridContainer/Unicorn/UnicornCheck
@onready var u_rew = $Unicorn_rew

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_items()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func check_items():
	hood = ResourceLoader.load(save_path + save_hoodie)
	if hood.score != 0:
		hoodie.show()
		if hood.score == 2:
			hoodie_check.button_pressed = false
			h_rew.hide()
		else:
			hoodie_check.button_pressed = true
			h_rew.show()
	glass = ResourceLoader.load(save_path + save_glass)
	if glass.score != 0:
		glasses.show()
		if glass.score == 2:
			glasses_check.button_pressed = false
			g_rew.hide()
		else:
			glasses_check.button_pressed = true
			g_rew.show()
	corn = ResourceLoader.load(save_path + save_corn)
	if corn.score != 0:
		unicorn.show()
		if corn.score == 2:
			unicorn_check.button_pressed = false
			u_rew.hide()
		else:
			unicorn_check.button_pressed = true
			u_rew.show()


func _on_hoodie_check_toggled(button_pressed):
	hood = ResourceLoader.load(save_path + save_hoodie)
	if button_pressed == false:
		hood.score = 2
		ResourceSaver.save(hood, save_path + save_hoodie)
	else:
		hood.score = 1
		ResourceSaver.save(hood, save_path + save_hoodie)


func _on_glasses_check_toggled(button_pressed):
	glass = ResourceLoader.load(save_path + save_glass)
	if button_pressed == false:
		glass.score = 2
		ResourceSaver.save(glass, save_path + save_glass)
	else:
		glass.score = 1
		ResourceSaver.save(glass, save_path + save_glass)


func _on_unicorn_check_toggled(button_pressed):
	corn = ResourceLoader.load(save_path + save_corn)
	if button_pressed == false:
		corn.score = 2
		ResourceSaver.save(corn, save_path + save_corn)
	else:
		corn.score = 1
		ResourceSaver.save(corn, save_path + save_corn)
