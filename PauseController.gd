extends Node

@export var can_pause : bool = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	
func resume() -> void:
	get_tree().paused = false
