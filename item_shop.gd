extends Control


var save_path = "user://save/"
var save_xp = "Exp.tres"
var save_corn = "Unicorn.tres"
var save_hoodie = "Hoodie.tres"
var save_glass = "Glasses.tres"

var item = PlayerData.new()
var item2 = PlayerData.new()
var item3 = PlayerData.new()

var playerXP = PlayerData.new()
var exp = null

var unicorn = 0
var glasses = 0
var hoodie = 0


var vynulovat = 0


@onready var label = $Label
@onready var glassesprice = $GlassesPrice
@onready var unicornprice = $UnicornPrice
@onready var hoodieprice = $HoodiePrice
@onready var error = $Error

# Called when the node enters the scene tree for the first time.
func _ready():
	playerXP = ResourceLoader.load(save_path + save_xp).duplicate(true)
	label.text = label.text + str(playerXP.score)
	exp = playerXP.score
	if exp < int(glassesprice.text):
		glassesprice.add_theme_color_override("font_color", "Red")
	else:
		glassesprice.add_theme_color_override("font_color", "Green")

	if exp < int(unicornprice.text):
		unicornprice.add_theme_color_override("font_color", "Red")
	else:
		unicornprice.add_theme_color_override("font_color", "Green")

	if exp < int(hoodieprice.text):
		hoodieprice.add_theme_color_override("font_color", "Red")
	else:
		hoodieprice.add_theme_color_override("font_color", "Green")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_label()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_hoodie_pressed():
	item = ResourceLoader.load(save_path + save_hoodie)
	if item.score == 1:
		hoodieprice.text = "Equipped"
		error.text = "You already koupit si to.."
		error.show()
	else:
		if exp < int(hoodieprice.text):
			error.text = "You don't have enough XP!"
		else:
			hoodieprice.text = "Equipped"
			error.text = "Succesful!"
			error.show()
			playerXP.score = playerXP.score - 1000
			label.text = "Your XP: " + str(playerXP.score)
			ResourceSaver.save(playerXP, save_path + save_xp)
			hoodie = 1
			item.reset_score()
			item.change_score(hoodie)
			ResourceSaver.save(item, save_path + save_hoodie)
			print(item.score)
		




func _on_unicorn_pressed():
	item = ResourceLoader.load(save_path + save_corn).duplicate(true)
	if item.score == 1:
		unicornprice.text = "Equipped"
		error.text = "You already koupit si to.."
		error.show()
	else:
		if exp < int(unicornprice.text):
			error.text = "You don't have enough XP!"
		else:
			unicornprice.text = "Equipped"
			error.text = "Succesful!"
			error.show()
			playerXP.score = playerXP.score - 500
			label.text = "Your XP: " + str(playerXP.score)
			ResourceSaver.save(playerXP, save_path + save_xp)
			unicorn = 1
			item.reset_score()
			item.change_score(unicorn)
			ResourceSaver.save(item, save_path + save_corn)
			print(item.score)




func _on_glasses_pressed():
	item = ResourceLoader.load(save_path + save_glass).duplicate(true)
	if item.score == 1:
		glassesprice.text = "Equipped"
		error.text = "You already koupit si to.."
		error.show()
	else:
		if exp < int(glassesprice.text):
			error.text = "You don't have enough XP!"
		else:
			glassesprice.text = "Equipped"
			error.text = "Succesful!"
			error.show()
			playerXP.score = playerXP.score - 100
			label.text = "Your XP: " + str(playerXP.score)
			ResourceSaver.save(playerXP, save_path + save_xp)
			glasses = 1
			item.reset_score()
			item.change_score(glasses)
			ResourceSaver.save(item, save_path + save_glass)
		print(item.score)

func check_label():
	item = ResourceLoader.load(save_path + save_glass).duplicate(true)
	if item.score == 0:
		glassesprice.text = "100,-"
	else:
		glassesprice.text = "Equipped"
	item2 = ResourceLoader.load(save_path + save_corn).duplicate(true)
	if item2.score == 0:
		unicornprice.text = "500,-"
	else:
		unicornprice.text = "Equipped"
	item3 = ResourceLoader.load(save_path + save_hoodie).duplicate(true)
	if item3.score == 0:
		hoodieprice.text = "1000,-"
	else:
		hoodieprice.text = "Equipped"
	


	


func _on_reset_pressed():
	item = ResourceLoader.load(save_path + save_glass).duplicate(true)
	item.score = vynulovat
	print(item.score)
	ResourceSaver.save(item, save_path + save_glass)
	item2 = ResourceLoader.load(save_path + save_corn).duplicate(true)
	item2.score = vynulovat
	print(item2.score)
	ResourceSaver.save(item, save_path + save_corn)
	item3 = ResourceLoader.load(save_path + save_hoodie).duplicate(true)
	item3.score = vynulovat
	print(item3.score)
	ResourceSaver.save(item, save_path + save_hoodie)
