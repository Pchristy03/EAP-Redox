extends Area2D

const speed = 750

var velocity_dir

signal hit_asteroid

func _ready():
	velocity_dir = Vector2(0, -1)  # Adjust this direction according to your projectile's initial movement
	velocity_dir = velocity_dir.normalized()

func _physics_process(delta):
	position += velocity_dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Asteroids"):
		emit_signal("hit_asteroid", self)
		queue_free()
