extends CharacterBody2D
@export var asteroid: PackedScene

var dest_dir = Vector2.ZERO

const impulse_speed = 0.5
const gravity_speed = 7

func init(dest):
	dest_dir = position.direction_to(Vector2(position.x, position.y + 1))
	velocity += dest_dir * impulse_speed

func _physics_process(delta):
	velocity += position.direction_to(Vector2(390, 650)) * gravity_speed * delta
	move_and_slide()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	# queue_free()
	pass

func activate_particle():
	$Explosion.emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		body.game_over() 
