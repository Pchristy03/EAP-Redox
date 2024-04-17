extends Node

@export var ast_scene: PackedScene
@export var proj_scene: PackedScene
@export var play_scene: PackedScene


var text_handler = FileAccess.open(("res://redoxcomp.txt"), FileAccess.READ)

var laser_type = 0
var num_asteroids_hit
var asteroids_to_spawn = 7
var answer = 3
var game_over = false
var won = false

func _ready():
	randomize()
	incr_HUD()
	create_random_ast(asteroids_to_spawn, answer)
	
func paused():
	get_tree().set_pause(true)
	$PauseMenu.visible = true
	$PauseMenu/ScreenBlur.visible = true

func resume():
	get_tree().set_pause(false)
	$PauseMenu.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause") and not game_over:
		if get_tree().paused:
			resume()
		else:
			paused()

func create_random_ast(number_of_asters, ans):
	# create spawning area
	var spawnArea = Rect2(0, -25, 750, 0)
	num_asteroids_hit = 0
	#print(number_of_asters)
	for i in range(number_of_asters):
		if not game_over:
			var aster = ast_scene.instantiate()

			var randomX = randf_range(spawnArea.position.x, spawnArea.end.x) 
			var randomY = randf_range(spawnArea.position.y, spawnArea.end.y)
			aster.position = Vector2(randomX, randomY)
			
			var num = randi_range(0, 9)
			if i == answer:
				aster.init(true, ans)
			elif i == number_of_asters-1:
				aster.init(true, ans)
			else:
				aster.init(false, num)
			aster.hit.connect(_on_asteroid_hit)
			aster.add_to_group("Asteroids")
			call_deferred("add_child", aster)
			
			var timeout_dur = randf_range(0.7, 2.4)
			#print(aster.position, timeout_dur)
			await get_tree().create_timer(timeout_dur).timeout

func next_line():
	return text_handler.get_line()

func incr_HUD():
	var next_set = str_to_var(next_line())
	$HUD/EquationBG/Equation.text = next_set["equation"]
	if randf() >= 0.5:
		$HUD/InstrBG/Instruction.text = "What is the Oxidation change of " + next_set["oxchem"]
		answer = next_set["oxchan"]
	else:
		$HUD/InstrBG/Instruction.text = "What is the Reduction change of " + next_set["redchem"]
		answer = next_set["redchan"]
	print("Answer: ", answer)

func enter_game_over():
	game_over = true
	print('Game Over')
	get_tree().call_group("Asteroids", "activate_particle", false)
	$HUD/GAMEOVERBackground.show()
	$HUD/GAMEOVERBackground/Restart.show()
	$Player.set_game_over()

func _on_asteroid_hit(corr, num):
	if not game_over:
		num_asteroids_hit += 1
		if num == 0:
			if corr:
				won = true
			else:
				$Player.wrong_answer()
		if num_asteroids_hit >= asteroids_to_spawn and not game_over:
			if won:
				print("Won")
			else:
				print("Didn't get correct answer")
			won = false
			asteroids_to_spawn = randi_range(7, 9)
			incr_HUD()
			create_random_ast(asteroids_to_spawn, answer)

func _on_player_shoot(location):
	var proj = proj_scene.instantiate()
	proj.position = location
	proj.setColor(laser_type)
	proj.add_to_group("Projectiles")
	add_child(proj)

func _on_player_hurt():
	if $Player.lives ==2:
		$HUD/HeartBG/HeartContainer/Heart3.hide()
	if $Player.lives ==1:
		$HUD/HeartBG/HeartContainer/Heart2.hide()
	if $Player.lives ==0:
		$HUD/HeartBG/HeartContainer/Heart1.hide()
		enter_game_over()

func _on_area_2d_body_entered(body):
	$Player._on_body_entered(body)

func _on_pause_menu_toggle_resume():
	resume()

func _on_pause_menu_quit():
	get_tree().quit()

func _on_hud_restart():
	get_tree().reload_current_scene()


func _on_player_laser_type(laserType):
	laser_type = laserType
	if laser_type == 0:
		$HUD/AmmoTypeOutline/BlueAmmoTypeBG.show()
		$HUD/AmmoTypeOutline/RedAmmoTypeBG2.hide()
	else:
		$HUD/AmmoTypeOutline/BlueAmmoTypeBG.hide()
		$HUD/AmmoTypeOutline/RedAmmoTypeBG2.show()
