extends Node

@export var ast_scene: PackedScene

func _ready():
	create_ast(3, [100, 300, 500])

func create_ast(amount, start_points):
	for i in range(amount):
		var aster = ast_scene.instantiate()
		aster.init(Vector2(start_points[i], 50), Vector2(start_points[i], 500), 1200)
		aster.add_to_group("Asteroids")
		add_child(aster)
