extends Node

@export var ast_scene: PackedScene
@export var proj_scene: PackedScene

func _ready():
	create_ast([100, 300, 500])

func create_ast(start_points):
	for i in range(len(start_points)):
		var aster = ast_scene.instantiate()
		aster.position = Vector2(start_points[i], 0)
		aster.add_to_group("Asteroids")
		add_child(aster)

func _on_player_shoot(location):
	var proj = proj_scene.instantiate()
	proj.position = location
	proj.add_to_group("Projectiles")
	add_child(proj)


func _on_player_hurt():
	if $Player.lives ==2:
		$HUD/Heart3.hide()
	if $Player.lives ==1:
		$HUD/Heart2.hide()
	if $Player.lives ==0:
		$HUD/Heart1.hide()
