extends CharacterBody2D

signal shoot(location)
signal hurt
@export var lives: int = 3

const move_speed = 300
const shoot_cooldown = 0.5

var can_shoot = true
var cooldown_timer = 0

const l_boundary = 10
const r_boundary = 750

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		emit_signal("shoot", Vector2(position.x, (position.y - 10)))
		can_shoot = false
		cooldown_timer = shoot_cooldown
		
		# Update cooldown timer
	if !can_shoot:
		cooldown_timer -= get_process_delta_time()
		if cooldown_timer <= 0:
			can_shoot = true
			
func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		
	if position.x <= l_boundary and velocity.x < 0:
		velocity = Vector2.ZERO
	elif position.x >= r_boundary and velocity.x > 0:
		velocity = Vector2.ZERO
	
	position = position.clamp(Vector2(l_boundary, 500), Vector2(r_boundary, 500))
	move_and_slide()


func _on_body_entered(body):
	lives -=1
	body.queue_free()
	hurt.emit()
	#if lives == 0:
