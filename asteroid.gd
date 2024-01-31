extends RigidBody2D

var velocity = Vector2.ZERO
var velocity_dir = Vector2.ZERO

var move_speed = 0

func init(start_pos, end_pos, speed):
	position = start_pos
	velocity_dir = end_pos - start_pos
	velocity_dir = velocity_dir.normalized()
	move_speed = speed

func _ready():
	pass

func _physics_process(delta):
	linear_velocity = velocity_dir * move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
