extends CharacterBody2D

@export var asteroid: PackedScene

var dest_dir = Vector2.ZERO

const impulse_speed = 0.5
const gravity_speed = 7

# Flag to check if the explosion has occurred
var explosion_occurred = false

func _ready():
	$AnimatedSprite2D.frame = 1

func init(dest):
	dest_dir = position.direction_to(Vector2(position.x, position.y + 1))
	velocity += dest_dir * impulse_speed

# Move the asteroid in the physics process
func _physics_process(delta):
	# If explosion hasn't occurred, move the asteroid
	if not explosion_occurred:
		velocity += position.direction_to(Vector2(390, 650)) * speed * delta
	else:
		# If explosion has occurred, stop the asteroid
		velocity = Vector2.ZERO
		# Make the asteroid invisible
		$AnimatedSprite2D.visible = false
	move_and_slide()
	
# Function to handle when the asteroid exits the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	pass
	
# Function to activate the particle system for explosion
func activate_particle(): 
	# Activate the explosion particle system
	$Explosion.emitting = true
	# Set the explosion flag to true
	explosion_occurred = true
	await get_tree().create_timer(2).timeout
	queue_free()
