extends Node

@export var ast_scene: PackedScene
@export var proj_scene: PackedScene
@export var play_scene: PackedScene


var text_handler = FileAccess.open(("res://"), FileAccess.READ)

var laser_type = 0
var num_asteroids_hit
var asteroids_to_spawn = 7
var answer = 3
var game_over = false

func _ready():
	randomize()
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

func next():
	return text_handler.next_line().split(",", false)

func incr_HUD():
	var next_set = next()
	$HUD/EquationBG/Equation.text = [0] #Replace with index of Equation
	$HUD/InstrBG/Instruction.text = [0]

func enter_game_over():
	game_over = true
	print('game over')
	get_tree().call_group("Asteroids", "activate_particle", false)
	$HUD/GAMEOVERBackground.show()
	$HUD/GAMEOVERBackground/Restart.show()
	$Player.set_game_over()

func _on_asteroid_hit(corr):
	if not $Player.lives == 0:
		num_asteroids_hit += 1
		#print(num_asteroids_hit)
		if corr and not game_over:
			pass
		if num_asteroids_hit >= asteroids_to_spawn and not game_over:
			print("win")
			
			asteroids_to_spawn = randi_range(5, 9)
			answer = randi_range(1, 9)
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
