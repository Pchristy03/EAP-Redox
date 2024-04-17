extends Area2D

const speed = 750

var velocity_dir


func _ready():
	velocity_dir = Vector2(0, -1).normalized() 

func _physics_process(delta):
	position += velocity_dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func setColor(num):
	$AnimatedSprite2D.frame = num 

func _on_body_entered(body):
	body.activate_particle($AnimatedSprite2D.frame)
	queue_free()
