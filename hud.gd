extends CanvasLayer

signal restart()



func _on_restart_pressed():
	emit_signal("restart")
	
