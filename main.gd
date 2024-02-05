extends Node

@export var ast_scene: PackedScene
@export var proj_scene: PackedScene

func _ready():
	create_ast([100, 300, 500])

func create_ast(start_points):
	for i in range(len(start_points)):
		var aster = ast_scene.instantiate()
		aster.init(Vector2(start_points[i], 50), Vector2(start_points[i], 500))
		aster.add_to_group("Asteroids")
		add_child(aster)
		

func _on_player_shoot(location):
	var proj = proj_scene.instantiate()
	proj.position = location
	proj.add_to_group("Projectiles")
	add_child(proj)
