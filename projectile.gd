extends Area2D

const speed = 750

var velocity_dir

func _ready():
	velocity_dir = Vector2(position.x, position.y - 100) - position
	velocity_dir = velocity_dir.normalized()

func _physics_process(delta):
	position += velocity_dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
