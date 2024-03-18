extends Sprite2D

var texture1 : Texture
var texture2 : Texture
var currentTextureIndex = 0

func _ready():
	texture1 = preload("res://Art Assets/laser_blue.png")
	texture2 = preload("res://Art Assets/laser_red.png")

func _input(event):
	if event.is_action_pressed("ui_accept"): # Change "ui_accept" to the desired action name
		_switch_texture()

func _switch_texture():
	# Switch between textures
	if currentTextureIndex == 0:
		self.texture = texture2
		currentTextureIndex = 1
	else:
		self.texture = texture1
		currentTextureIndex = 0
