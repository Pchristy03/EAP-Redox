extends Control
signal toggleResume()
signal Quit()


func _on_button_pressed():
	emit_signal("toggleResume")



func _on_quit_pressed():
	emit_signal("Quit")
