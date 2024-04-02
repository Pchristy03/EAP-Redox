extends CharacterBody2D

signal hit(corr)

var dest_dir = Vector2.ZERO

const max_speed = 40
const impulse_speed = 30
const gravity_speed = 2

var correctness = false

# Flag to check if the explosion has occurred
var explosion_occurred = false

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 3)
	dest_dir = position.direction_to(Vector2(randi_range(0, 800), 350))
	velocity += dest_dir * impulse_speed

func init(corr, num):
	correctness = corr
	$Value.text = str(num)

# Move the asteroid in the physics process
func _physics_process(delta):
	# If explosion hasn't occurred, move the asteroid
	if not explosion_occurred:
		velocity += position.direction_to(Vector2(390, 650)) * delta * gravity_speed
		velocity = velocity.clamp(Vector2(-max_speed, -max_speed), Vector2(max_speed, max_speed))
		#print(velocity)
	else:
		# If explosion has occurred, stop the asteroid
		velocity = Vector2.ZERO
	move_and_slide()

# Function to activate the particle system for explosion
func activate_particle(): 
	# Activate the explosion particle system
	$Explosion.emitting = true
	# Set the explosion flag to true
	explosion_occurred = true
	# Make the asteroid invisible
	$AnimatedSprite2D.visible = false
	$Value.visible = false
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(4, false)
	emit_signal("hit", correctness)
	await get_tree().create_timer(2).timeout
	queue_free()
