extends CharacterBody2D

class_name Player

# Vlastnosti pro pohyb postavy
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# Uzly animací
var animationPlayer = null
var animationTree = null
var animationState = null

@onready var timer = $Timer #časovač čůrání
@onready var timer2 = $Timer2 #časovač pití
@onready var error = $ErrorStatement #label na errory
@onready var score_label = $Score #label na skore
@onready var remaining_time = $RemainingTime #časovač hry


var remaining_time_value = 60 #čas hry

var interaction_manager = null
var interaction_manager2 = null
var progressbar = null


var peeing: bool = false
var pee_timer: float = 6 # Doba čůrání
var pee_duration: float = 1  

var drinking: bool = false
var drink_timer: float = 6 # Doba pití
var drink_duration: float = 1 

var display_time: float = 2
var elapsed_time: float = 0

#skore
var score: float = 0

#ukládání skore
var save_path = "user://save/"
var save_name = "PlayerSave.tres"

var playerData = PlayerData.new()


func _ready():
	# přiřazení odkazy na uzly
	verify_save_dir(save_path)
	progressbar = $ProgressBar
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	interaction_manager = $"/root/InteractionManager" #interaction_manager pro čůrání
	interaction_manager2 = $"/root/InteractionManager2" #interaction_manager pro pití
	animationState = animationTree.get("parameters/playback")
	timer.hide()
	timer2.hide()
	error.hide()
	score_label.text = "Score: " + str(score)
	
	
	
	#kontrola připojení ke proměnné can_pee
	if interaction_manager:
		var can_pee_value = interaction_manager.can_pee
		print(can_pee_value)
	else:
		print("chyba")

	if interaction_manager2:
		var can_drink_value = interaction_manager2.can_drink
		print(can_drink_value)
	else:
		print("chyba")



func _physics_process(delta):
	
	remaining_time_value -= delta
	
	if remaining_time_value < 0:
		remaining_time_value = 0
		get_tree().change_scene_to_file("res://endgame.tscn")

	remaining_time.text = str(floor(remaining_time_value)) + " seconds remaining!"
	
	if remaining_time_value < 30:
		remaining_time.add_theme_color_override("font_color", "Yellow")
		
	if remaining_time_value < 15:
		remaining_time.add_theme_color_override("font_color", "Red")
		
	
	
	# Získání vstupu od hráče a jeho směrového vektoru
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	# Zkontroluj, zda hráč ovládá postavu
	if input_vector != Vector2.ZERO:
		# Nastav blend pozice pro animace klidu achůze
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		
		
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		# Pokud hráč nemá žádný vstup, animace se pozastaví na "Idle"
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
	
	if Input.is_action_just_pressed("Pee"):
		if interaction_manager.can_pee == true:
			if progressbar.value > 0:
				pee()
			else:
				error.text = "There is no piss to pee..."
				error.show()
				await get_tree().create_timer(1.0).timeout
				error.hide()
				
				
			
			
		else:
			error.text = "You can't do it here..."
			error.show()
			await get_tree().create_timer(1.0).timeout
			error.hide()

	if Input.is_action_just_released("Pee"):
		if interaction_manager.can_pee == true:
			if progressbar.value > 0:
				stop_peeing()
			
	if peeing:
		
		
		# Kontrola časovače
		pee_timer -= delta
		timer.show()
		timer.text = str(floor(pee_timer)) + "s"

		if pee_timer <= pee_duration:
			# Ubrat hráči tekutiny z progressbaru
			
			progressbar.value -= 25
			score += 100
			score_label.text = "Score: " + str(score)
			#uložit score do resource
			playerData.reset_score()
			playerData.change_score(score)
			save_score()
			
			# Zastavit čurání po uplynutí 5 vteřin
			stop_peeing()
			
	if Input.is_action_just_pressed("Drink"):
		if interaction_manager2.can_drink == true:
			if progressbar.value < 100:
				drink()
			else:
				error.text = "I think you're not thirsty enough..."
				error.show()
				await get_tree().create_timer(1.0).timeout
				error.hide()
			
			
			
			
		else:
			error.text = "You can't do it here..."
			error.show()
			await get_tree().create_timer(1.0).timeout
			error.hide()

	if Input.is_action_just_released("Drink"):
		if interaction_manager2.can_drink == true:
			if progressbar.value < 100:
				stop_drinking()
			
	if drinking:
		
		
		# Kontrola časovače
		drink_timer -= delta
		timer2.show()
		timer2.text = str(floor(drink_timer)) + "s"

		if drink_timer <= drink_duration:
			# Ubrat hráči tekutiny z progressbaru
			progressbar.value += 25
			# Zastavit čurání po uplynutí 5 vteřin
			stop_drinking()
			
func pee():
	if not peeing:
			
		print("čůrám")
		
			
		peeing = true
		pee_timer = 6  # Resetovat časovač
				

		
func stop_peeing():
	print("končim!")

	timer.hide()
	
	peeing = false
	pee_timer = 6  # Resetovat časovač
	
	

			
func drink():
	if not drinking:
			
		print("piju")
		
			
		drinking = true
		drink_timer = 6  # Resetovat časovač
				

		
func stop_drinking():
	print("jsem plnej!")

	timer2.hide()
	
	drinking = false
	drink_timer = 6  # Resetovat časovač

func save_score() -> void:
	print("ukládám score")
	ResourceSaver.save(playerData, save_path + save_name)

func verify_save_dir(path : String):
	DirAccess.make_dir_absolute(path)

