extends CharacterBody2D

signal shoot(location)
signal hurt
@export var lives: int = 3

const move_speed = 300

const accel = 600
const shoot_cooldown = 0.5

var shot_type = 0
var can_shoot = true
var cooldown_timer = 0
var game_over = false

const l_boundary = 10
const r_boundary = 750

func _process(_delta):
	# Check if the "ui_accept" action is just pressed and the player can shoot
	if Input.is_action_just_pressed("ui_accept") and can_shoot and not game_over:
		# Emit a "shoot" signal with the current position adjusted slightly upwards and the current shot type
		emit_signal("shoot", Vector2(position.x, (position.y - 10)), shot_type)
		# Set can_shoot to false to prevent shooting until cooldown is over
		can_shoot = false
		# Start the cooldown timer
		cooldown_timer = shoot_cooldown
		
	# Check if the "switch_laser" action is just pressed
	elif Input.is_action_just_pressed("switch_laser") and not game_over:
		if shot_type == 0:
			shot_type = 1
		else:
			shot_type = 0
				
	# If the player can't shoot due to cooldown
	if !can_shoot:
		cooldown_timer -= get_process_delta_time()
		if cooldown_timer <= 0:
			can_shoot = true
			
func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and not game_over:
		if velocity.x == 0 || velocity.x/direction > 0:
			velocity.x = move_toward(velocity.x, move_speed*direction, accel*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, accel/30)
	else:
		velocity.x = move_toward(velocity.x, 0, accel/30)
		
	if position.x <= l_boundary and velocity.x < 0:
		velocity = Vector2.ZERO
	elif position.x >= r_boundary and velocity.x > 0:
		velocity = Vector2.ZERO
	
	position = position.clamp(Vector2(l_boundary, 500), Vector2(r_boundary, 500))
	move_and_slide()

func set_game_over():
	game_over = true

func _on_body_entered(body):
	lives -=1
	body.activate_particle()
	hurt.emit()
