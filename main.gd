extends Node

@export var ast_scene: PackedScene
@export var proj_scene: PackedScene

var text_handler = FileAccess.open(("res://"), FileAccess.READ)

func _ready():
	create_random_ast(10)
	
func paused():
	get_tree().set_pause(true)
	$PauseMenu.visible = true

func resume():
	get_tree().set_pause(false)
	$PauseMenu.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause"):
		if get_tree().paused:
			resume()
		else:
			paused()

func create_random_ast(number_of_asters):
	# create spawning area
	var spawnArea = Rect2(0, -25, 750, 0)
	
	for i in range(number_of_asters + 1):
		var aster = ast_scene.instantiate()

		var randomX = randf_range(spawnArea.position.x, spawnArea.end.x) 
		var randomY = randf_range(spawnArea.position.y, spawnArea.end.y)
		aster.position = Vector2(randomX, randomY)
		#Arg1 is destination Arg2 is for the value
		aster.init(-1, -1)
		aster.add_to_group("Asteroids")
		add_child(aster)
		
		var timeout_dur = randf_range(0.7, 2.4)
		#print(aster.position, timeout_dur)
		await get_tree().create_timer(timeout_dur).timeout

func next():
	return text_handler.next_line().split(",", false)

func incr_HUD():
	var next_set = next()
	$HUD/EquationBG/Equation.text = [0] #Replace with index of Equation
	$HUD/InstrBG/Instruction.text = [0]
	pass

func enter_game_over():
	get_tree().call_group("Asteroids", "activate_particle")

func _on_player_shoot(location, color):
	var proj = proj_scene.instantiate()
	proj.position = location
	proj.setColor(color)
	proj.add_to_group("Projectiles")
	add_child(proj)


func _on_player_hurt():
	if $Player.lives ==2:
		$HUD/HudBG/HeartBG/HeartContainer/Heart3.hide()
	if $Player.lives ==1:
		$HUD/HudBG/HeartBG/HeartContainer/Heart2.hide()
	if $Player.lives ==0:
		$HUD/HudBG/HeartBG/HeartContainer/Heart1.hide()
		$HUD/GAMEOVERBackground.show()
		enter_game_over()
		await get_tree().create_timer(2).timeout
		get_tree().set_pause(true)

func _on_area_2d_body_entered(body):
	$Player._on_body_entered(body)


func _on_pause_menu_toggle_resume():
	resume()
	

func _on_pause_menu_quit():
	get_tree().quit()
