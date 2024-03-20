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
	$ResumeIconButton.show()
	$PauseIconButton.hide()

func resume() -> void:
	$BlurAnimation.play_backwards("blur")
	get_tree().set_pause(false)
	$ResumeIconButton.hide()
	$PauseIconButton.show()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()

func _on_resume_icon_button_pressed():
	resume()

func _on_pause_icon_button_pressed():
	pause()
