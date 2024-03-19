extends Node

@export var can_pause : bool = true

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("menu_pause"):
	#	if get_tree().paused:
	#		resume()
	#	else:
	#		pause()
	pass

func pause() -> void:
	get_tree().set_pause(false)
	$ResumeButton.show()
	$PauseButton.hide()
	
	
func resume() -> void:
	get_tree().set_pause(true)
	$ResumeButton.hide()
	$PauseButton.show()
	

func _on_resume_button_pressed():
	resume()

func _on_pause_button_pressed():
	pause()

