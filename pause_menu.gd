extends Control

func _ready():
	$BlurAnimation.play("REST")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("menu_pause") and get_tree().paused:
		resume()

func pause() -> void:
	get_tree().paused = true
	$BlurAnimation.play("blur")
	# $ResumeButton.show()
	# $PauseButton.hide()

func resume() -> void:
	get_tree().paused = false
	$BlurAnimation.play_backwards("blur")
	# $ResumeButton.hide()
	# $PauseButton.show()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	get_tree().quit()
