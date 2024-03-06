extends Node

func _ready():
	#$BlurAnimation.play("RESET")
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	$BlurAnimation.play("blur")
	get_tree().set_pause(true)
	# $ResumeButton.show()
	# $PauseButton.hide()

func resume() -> void:
	$BlurAnimation.play_backwards("blur")
	get_tree().set_pause(false)
	# $ResumeButton.hide()
	# $PauseButton.show()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()
