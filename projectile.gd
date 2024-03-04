extends Area2D

const speed = 750

var velocity_dir


func _ready():
	velocity_dir = Vector2(0, -1).normalized()  # Adjust this direction according to your projectile's initial movement

func _physics_process(delta):
	position += velocity_dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_body_entered(body):
	print("test")
	body.activate_particle()
	queue_free()
