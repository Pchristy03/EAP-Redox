extends RigidBody2D

var velocity = Vector2.ZERO
var velocity_dir = Vector2.ZERO

const speed = 200

func init(start_pos, end_pos):
	position = start_pos
	velocity_dir = end_pos - start_pos
	velocity_dir = velocity_dir.normalized()

func _ready():
	pass

func _physics_process(_delta):
	linear_velocity = velocity_dir * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
